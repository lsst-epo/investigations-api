<?php

namespace modules\investigations\console\controllers;

use Craft;
use craft\base\ElementInterface;
use craft\base\FieldInterface;
use craft\console\Controller;
use craft\elements\Asset;
use craft\elements\db\ElementQuery;
use craft\elements\Entry;
use craft\errors\InvalidElementException;
use craft\fields\BaseRelationField;
use craft\fields\Matrix;
use craft\helpers\Console;
use craft\helpers\FileHelper;
use craft\helpers\StringHelper;
use yii\console\ExitCode;

/**
 * Imports the assessments bundle produced by rubin-obs-api into the Assessments
 * channel.
 *
 * Everything in the bundle is keyed by handle, so this maps handle-to-handle and
 * reports anything it cannot place rather than dropping it silently.
 *
 * Usage:
 *   php craft investigations/assessments/upload-assets --bundle=/path/to/bundle
 *   php craft investigations/assessments/import --bundle=/path/to/bundle --dry-run
 *   php craft investigations/assessments/import --bundle=/path/to/bundle
 */
class AssessmentsController extends Controller
{
    /** Section the assessments land in. */
    private const SECTION = 'assessments';

    /** Volume the migrated binaries land in (decision 3b). */
    private const VOLUME = 'contentImages';

    /** Source handle => target handle, where the two instances disagree. */
    private const FIELD_RENAMES = [
        'verticalAlignment' => 'verticalAlignnment',
    ];

    /**
     * Option values that differ between the instances. cellBackground is the only
     * option-list field whose values don't line up: both offer a "None" choice, but
     * the source stores it as '' and the target as 'none'. Every other option on
     * every other dropdown matches exactly.
     */
    private const VALUE_MAPS = [
        'cellBackground' => ['' => 'none'],
    ];

    /**
     * Source entry ID => target entry ID, for link blocks that pointed at a
     * source-only page (decision 6b).
     */
    private const LINK_REMAP = [
        118692 => 604, // Coloring the Universe
    ];

    public ?string $bundle = null;
    public bool $dryRun = false;
    public bool $allowMissingAssets = false;

    /** Username or email to credit as author. Defaults to the first admin. */
    public ?string $author = null;

    private ?int $authorId = null;

    /** @var array<int,int> sourceAssetId => targetAssetId */
    private array $assetMap = [];

    /** @var string[] */
    private array $warnings = [];

    /** @var array<string,int> */
    private array $droppedFields = [];

    public function options($actionID): array
    {
        return array_merge(parent::options($actionID), [
            'bundle',
            'dryRun',
            'allowMissingAssets',
            'author',
        ]);
    }

    // =========================================================================
    // Assets
    // =========================================================================

    /**
     * Uploads the bundle's binaries into the target volume and writes asset-map.json.
     */
    public function actionUploadAssets(): int
    {
        $dir = $this->bundleDir();
        if ($dir === null) {
            return ExitCode::UNSPECIFIED_ERROR;
        }

        $indexPath = $dir . '/assets/index.json';
        if (!is_file($indexPath)) {
            $this->stderr("No assets/index.json in the bundle. Run the exporter with GCS credentials first.\n", Console::FG_RED);
            return ExitCode::UNSPECIFIED_ERROR;
        }

        $index = $this->readJson($indexPath);
        if (empty($index)) {
            $this->stderr("assets/index.json is empty - the exporter did not fetch any binaries.\n", Console::FG_RED);
            return ExitCode::UNSPECIFIED_ERROR;
        }

        $volume = Craft::$app->getVolumes()->getVolumeByHandle(self::VOLUME);
        if (!$volume) {
            $this->stderr("Volume '" . self::VOLUME . "' not found.\n", Console::FG_RED);
            return ExitCode::UNSPECIFIED_ERROR;
        }

        $folder = Craft::$app->getAssets()->getRootFolderByVolumeId($volume->id);
        $map = [];
        $created = 0;
        $reused = 0;

        foreach ($index as $item) {
            $path = $dir . '/' . $item['file'];
            if (!is_file($path)) {
                $this->warnings[] = "Bundle file missing: {$item['file']}";
                continue;
            }

            // Don't re-upload something we already put here on a previous run.
            $existing = Asset::find()
                ->volumeId($volume->id)
                ->filename($item['filename'])
                ->status(null)
                ->one();

            if ($existing && $this->sameBytes($existing, $item['sha256'])) {
                $map[$item['assetRef']] = $existing->id;
                $reused++;
                continue;
            }

            if ($this->dryRun) {
                $map[$item['assetRef']] = 0;
                $created++;
                continue;
            }

            $asset = new Asset();
            $asset->tempFilePath = $path;
            $asset->setFilename($item['filename']);
            $asset->newFolderId = $folder->id;
            $asset->setVolumeId($volume->id);
            $asset->avoidFilenameConflicts = true;
            $asset->setScenario(Asset::SCENARIO_CREATE);
            if (!empty($item['alt'])) {
                $asset->alt = $item['alt'];
            }

            if (!Craft::$app->getElements()->saveElement($asset)) {
                $this->warnings[] = sprintf(
                    'Asset %s failed to save: %s',
                    $item['filename'],
                    implode('; ', $asset->getFirstErrors())
                );
                continue;
            }

            $map[$item['assetRef']] = $asset->id;
            $created++;
            $this->stdout(sprintf("\r  uploaded: %d", $created));
        }

        $this->stdout("\n");
        $this->stdout(sprintf("%d uploaded, %d already present.\n", $created, $reused), Console::FG_GREEN);

        if (!$this->dryRun) {
            $this->writeBundleJson($dir . '/asset-map.json', $map);
            $this->stdout("Wrote asset-map.json\n", Console::FG_GREEN);
        }

        $this->reportWarnings();

        return count($map) === count($index) ? ExitCode::OK : ExitCode::UNSPECIFIED_ERROR;
    }

    // =========================================================================
    // Import
    // =========================================================================

    public function actionImport(): int
    {
        $dir = $this->bundleDir();
        if ($dir === null) {
            return ExitCode::UNSPECIFIED_ERROR;
        }

        $records = $this->readJson($dir . '/assessments.json');
        if (empty($records)) {
            $this->stderr("assessments.json is empty or missing.\n", Console::FG_RED);
            return ExitCode::UNSPECIFIED_ERROR;
        }

        $mapPath = $dir . '/asset-map.json';
        if (is_file($mapPath)) {
            $this->assetMap = array_map('intval', $this->readJson($mapPath));
            $this->stdout(sprintf("Asset map: %d entries.\n", count($this->assetMap)));
        } elseif ($this->allowMissingAssets) {
            $this->stdout("No asset-map.json - asset relations will be skipped.\n", Console::FG_YELLOW);
        } else {
            $this->stderr(
                "No asset-map.json found. Run upload-assets first, or pass --allow-missing-assets "
                . "to import content without file relations.\n",
                Console::FG_RED
            );
            return ExitCode::UNSPECIFIED_ERROR;
        }

        $section = Craft::$app->getSections()->getSectionByHandle(self::SECTION);
        if (!$section) {
            $this->stderr("Section '" . self::SECTION . "' not found.\n", Console::FG_RED);
            return ExitCode::UNSPECIFIED_ERROR;
        }
        $entryType = $section->getEntryTypes()[0];

        // Entries need an author, and a console run has no logged-in user.
        $this->authorId = $this->resolveAuthorId();
        if ($this->authorId === null) {
            $this->stderr("Could not resolve an author. Pass --author=<username or email>.\n", Console::FG_RED);
            return ExitCode::UNSPECIFIED_ERROR;
        }
        $this->stdout(sprintf("Authoring as user #%d.\n", $this->authorId));

        $investigations = $this->loadInvestigations();
        $this->stdout(sprintf("Target investigations: %d.\n", count($investigations)));

        $primary = Craft::$app->getSites()->getPrimarySite();
        $created = 0;
        $updated = 0;
        $failed = 0;

        foreach ($records as $record) {
            $result = $this->importRecord($record, $section, $entryType, $investigations, $primary);
            match ($result) {
                'created' => $created++,
                'updated' => $updated++,
                default => $failed++,
            };
        }

        $this->stdout("\n");
        $this->stdout(sprintf(
            "%s: %d created, %d updated, %d failed.\n",
            $this->dryRun ? 'Dry run' : 'Import',
            $created,
            $updated,
            $failed
        ), $failed ? Console::FG_YELLOW : Console::FG_GREEN);

        if ($this->droppedFields) {
            $this->stdout("\nSource fields with no target counterpart:\n", Console::FG_YELLOW);
            foreach ($this->droppedFields as $handle => $count) {
                $this->stdout(sprintf("  %-28s %d value(s) with content\n", $handle, $count), Console::FG_YELLOW);
            }
        }

        $this->reportWarnings();

        return $failed ? ExitCode::UNSPECIFIED_ERROR : ExitCode::OK;
    }

    private function importRecord(
        array $record,
        $section,
        $entryType,
        array $investigations,
        $primary
    ): string {
        $en = $record['sites'][$primary->handle] ?? reset($record['sites']);
        if (!$en) {
            $this->warnings[] = "Record {$record['sourceEntryId']} has no site data.";
            return 'failed';
        }

        // Decision 5b: match by normalized title; the three new stubs are in here too.
        $investigation = null;
        if (!empty($record['investigation']['title'])) {
            $key = $this->normalizeTitle($record['investigation']['title']);
            $investigation = $investigations[$key] ?? null;
            if (!$investigation) {
                $this->warnings[] = sprintf(
                    'No target investigation matching "%s" (source #%d).',
                    $record['investigation']['title'],
                    $record['sourceEntryId']
                );
            }
        }

        // Decision 2a: prefix the slug with the *target* investigation's slug.
        $slug = $investigation
            ? $investigation->slug . '-' . $en['slug']
            : $en['slug'];

        $entry = Entry::find()
            ->sectionId($section->id)
            ->slug($slug)
            ->siteId($primary->id)
            ->status(null)
            ->one();

        $isNew = $entry === null;
        if ($isNew) {
            $entry = new Entry();
            $entry->sectionId = $section->id;
            $entry->typeId = $entryType->id;
        }

        $entry->siteId = $primary->id;
        $entry->authorId = $entry->authorId ?: $this->authorId;
        $entry->title = $en['title'];
        $entry->slug = $slug;
        $entry->enabled = (bool)$en['enabled'];
        $entry->setEnabledForSite((bool)$en['enabledForSite']);
        // Decision 8b: postDate is stamped at import, not carried from source.

        if ($investigation) {
            $entry->setFieldValue('investigationEntry', [$investigation->id]);
        }
        $entry->setFieldValue('contentBlocks', $this->buildBlocks($en['contentBlocks'], 'contentBlocks', $entry));

        if ($this->dryRun) {
            $entry->setScenario(Entry::SCENARIO_LIVE);
            if (!$entry->validate()) {
                $this->warnings[] = sprintf(
                    'Would fail on "%s": %s',
                    $slug,
                    json_encode($entry->getErrors())
                );
                return 'failed';
            }
            return $isNew ? 'created' : 'updated';
        }

        try {
            if (!Craft::$app->getElements()->saveElement($entry)) {
                $this->warnings[] = sprintf(
                    'Save failed for "%s": %s',
                    $slug,
                    json_encode($entry->getErrors())
                );
                return 'failed';
            }
        } catch (InvalidElementException $e) {
            $this->warnings[] = sprintf('Save threw for "%s": %s', $slug, $e->getMessage());
            return 'failed';
        }

        $this->applyOtherSites($entry, $record, $slug, $investigation, $primary);

        $this->stdout('.', Console::FG_GREEN);

        return $isNew ? 'created' : 'updated';
    }

    /**
     * Writes the non-primary locales, and disables FR (decision 4b) - the section
     * propagates to all three sites whether or not we want FR content.
     */
    private function applyOtherSites(
        Entry $canonical,
        array $record,
        string $slug,
        ?Entry $investigation,
        $primary
    ): void {
        foreach (Craft::$app->getSites()->getAllSites() as $site) {
            if ($site->id === $primary->id) {
                continue;
            }

            $localized = Entry::find()
                ->id($canonical->id)
                ->siteId($site->id)
                ->status(null)
                ->one();

            if (!$localized) {
                continue;
            }

            $siteData = $record['sites'][$site->handle] ?? null;

            if ($siteData === null) {
                // No source content for this locale - FR. Keep it off.
                $localized->setEnabledForSite(false);
                Craft::$app->getElements()->saveElement($localized);
                continue;
            }

            $localized->title = $siteData['title'];
            $localized->slug = $slug;
            $localized->setEnabledForSite((bool)$siteData['enabledForSite']);

            if ($investigation) {
                $localized->setFieldValue('investigationEntry', [$investigation->id]);
            }

            $blocks = $this->buildBlocksForSite($localized, $siteData['contentBlocks'], 'contentBlocks');

            if ($blocks === null) {
                $this->warnings[] = sprintf(
                    'Locale %s for "%s": propagated blocks do not line up with the source, so the '
                    . 'blocks were left alone rather than overwriting the %s content.',
                    $site->handle,
                    $slug,
                    $primary->handle
                );
            } else {
                $localized->setFieldValue('contentBlocks', $blocks);
            }

            if (!Craft::$app->getElements()->saveElement($localized)) {
                $this->warnings[] = sprintf(
                    'Locale %s failed for "%s": %s',
                    $site->handle,
                    $slug,
                    json_encode($localized->getErrors())
                );
            }
        }
    }

    // =========================================================================
    // Block building
    // =========================================================================

    /**
     * Turns the bundle's block list into the array shape Neo's normalizeValue expects.
     */
    private function buildBlocks(array $blocks, string $fieldHandle, ElementInterface $owner): array
    {
        $field = $this->findField($owner, $fieldHandle);
        if (!$field instanceof \benf\neo\Field) {
            return [];
        }

        $byHandle = [];
        foreach ($field->getBlockTypes() as $bt) {
            $byHandle[$bt->handle] = $bt;
        }

        $out = [];
        $n = 0;

        foreach ($blocks as $block) {
            $handle = $block['type'] ?? null;
            if ($handle === null || !isset($byHandle[$handle])) {
                $this->warnings[] = "No target Neo block type '{$handle}' on {$fieldHandle}.";
                continue;
            }

            $out['new' . ++$n] = [
                'type' => $handle,
                'enabled' => $block['enabled'] ?? true,
                'collapsed' => false,
                'level' => $block['level'] ?? 1,
                'fields' => $this->mapFields(
                    $block['fields'] ?? [],
                    $byHandle[$handle]->getFieldLayout()?->getCustomFields() ?? []
                ),
            ];
        }

        return $out;
    }

    // =========================================================================
    // Block building, non-primary sites
    // =========================================================================

    /**
     * Builds a payload that updates the blocks already propagated into $owner's
     * site, rather than creating new ones.
     *
     * contentBlocks is propagationMethod: all, so its blocks are shared elements -
     * one block ID with a content row per site. Submitting a fresh newN set on the
     * Spanish pass makes Neo replace the whole structure and seed every site from
     * the saving site's values, which is how English ends up holding Spanish text.
     * Reusing the existing IDs lets Neo write per-site content only where a field
     * is genuinely translatable.
     *
     * Returns null when the propagated structure doesn't line up with the source,
     * which is the caller's cue to leave the locale alone rather than overwrite
     * good English content on a guess.
     */
    private function buildBlocksForSite(ElementInterface $owner, array $sourceBlocks, string $fieldHandle): ?array
    {
        $field = $this->findField($owner, $fieldHandle);
        if (!$field instanceof \benf\neo\Field) {
            return null;
        }

        $existing = $this->existingBlocks($owner, $fieldHandle);
        if (count($existing) !== count($sourceBlocks)) {
            return null;
        }

        $byHandle = [];
        foreach ($field->getBlockTypes() as $bt) {
            $byHandle[$bt->handle] = $bt;
        }

        $sortOrder = [];
        $blocks = [];

        foreach (array_values($existing) as $i => $block) {
            $handle = $block->getType()->handle;
            if (($sourceBlocks[$i]['type'] ?? null) !== $handle) {
                return null;
            }

            $sortOrder[] = $block->id;
            $blocks[$block->id] = [
                'type' => $handle,
                'enabled' => $block->enabled,
                'level' => $block->level,
                'fields' => $this->mapFieldsForSite(
                    $block,
                    $sourceBlocks[$i]['fields'] ?? [],
                    $byHandle[$handle]?->getFieldLayout()?->getCustomFields() ?? []
                ),
            ];
        }

        // Neo only honours existing block IDs in the delta format - given a plain
        // array it rewrites every key to newN. Matrix and Super Table both accept
        // the plain keyed form.
        return ['sortOrder' => $sortOrder, 'blocks' => $blocks];
    }

    /**
     * mapFields() for a non-primary site.
     *
     * Containers always recurse, whatever their own translation method, because
     * their translatable descendants still need writing. Leaf fields are included
     * only when they're translatable - anything else shares one value with English,
     * so writing it here would overwrite that.
     *
     * @param FieldInterface[] $targetFields
     */
    private function mapFieldsForSite(ElementInterface $owner, array $source, array $targetFields): array
    {
        $byHandle = [];
        foreach ($targetFields as $f) {
            $byHandle[$f->handle] = $f;
        }

        $out = [];

        foreach ($source as $handle => $value) {
            $targetHandle = self::FIELD_RENAMES[$handle] ?? $handle;
            $target = $byHandle[$targetHandle] ?? null;

            if ($target === null) {
                // Already counted on the primary pass; don't double-report it.
                continue;
            }

            if ($target instanceof Matrix) {
                $nested = $this->buildMatrixForSite($owner, $target, $value);
                if ($nested !== null) {
                    $out[$targetHandle] = $nested;
                }
                continue;
            }

            if ($target instanceof \verbb\supertable\fields\SuperTableField) {
                $nested = $this->buildSuperTableForSite($owner, $target, $value);
                if ($nested !== null) {
                    $out[$targetHandle] = $nested;
                }
                continue;
            }

            if (!$target->getIsTranslatable($owner)) {
                continue;
            }

            if (isset(self::VALUE_MAPS[$targetHandle])
                && (is_string($value) || $value === null)
                && array_key_exists((string)$value, self::VALUE_MAPS[$targetHandle])) {
                $value = self::VALUE_MAPS[$targetHandle][(string)$value];
            }

            $out[$targetHandle] = $this->mapValue($target, $value);
        }

        return $out;
    }

    private function buildMatrixForSite(ElementInterface $owner, Matrix $field, mixed $value): ?array
    {
        if (!is_array($value)) {
            return null;
        }

        $existing = $this->existingBlocks($owner, $field->handle);
        if (count($existing) !== count($value)) {
            return null;
        }

        $byHandle = [];
        foreach ($field->getBlockTypes() as $bt) {
            $byHandle[$bt->handle] = $bt;
        }

        $value = array_values($value);
        $out = [];

        foreach (array_values($existing) as $i => $block) {
            $handle = $block->getType()->handle;
            if (($value[$i]['type'] ?? null) !== $handle) {
                return null;
            }

            // Every existing block has to stay in the payload - the keys double as
            // the sort order, so an omitted block is a deleted block.
            $out[$block->id] = [
                'type' => $handle,
                'enabled' => $block->enabled,
                'fields' => $this->mapFieldsForSite(
                    $block,
                    $value[$i]['fields'] ?? [],
                    $byHandle[$handle]?->getFieldLayout()?->getCustomFields() ?? []
                ),
            ];
        }

        return $out;
    }

    private function buildSuperTableForSite(
        ElementInterface $owner,
        \verbb\supertable\fields\SuperTableField $field,
        mixed $value
    ): ?array {
        if (!is_array($value)) {
            return null;
        }

        $blockTypes = $field->getBlockTypes();
        if (empty($blockTypes)) {
            return null;
        }

        $existing = $this->existingBlocks($owner, $field->handle);
        if (count($existing) !== count($value)) {
            return null;
        }

        $layoutFields = $blockTypes[0]->getFieldLayout()?->getCustomFields() ?? [];
        $value = array_values($value);
        $out = [];

        foreach (array_values($existing) as $i => $block) {
            $out[$block->id] = [
                'type' => $blockTypes[0]->id,
                'fields' => $this->mapFieldsForSite($block, $value[$i]['fields'] ?? [], $layoutFields),
            ];
        }

        return $out;
    }

    /**
     * The blocks already propagated into $element's site, in sort order.
     *
     * @return ElementInterface[]
     */
    private function existingBlocks(ElementInterface $element, string $handle): array
    {
        try {
            $value = $element->getFieldValue($handle);
        } catch (\Throwable) {
            return [];
        }

        if ($value instanceof ElementQuery) {
            return (clone $value)->status(null)->all();
        }

        if (is_iterable($value)) {
            return is_array($value) ? $value : iterator_to_array($value);
        }

        return [];
    }

    /**
     * Maps a bundle "fields" object onto the target field layout, by handle.
     *
     * @param array $source handle => exported value
     * @param FieldInterface[] $targetFields
     */
    private function mapFields(array $source, array $targetFields): array
    {
        $byHandle = [];
        foreach ($targetFields as $f) {
            $byHandle[$f->handle] = $f;
        }

        $out = [];

        foreach ($source as $handle => $value) {
            $targetHandle = self::FIELD_RENAMES[$handle] ?? $handle;
            $target = $byHandle[$targetHandle] ?? null;

            if ($target === null) {
                if (!$this->isEmptyValue($value)) {
                    $this->droppedFields[$handle] = ($this->droppedFields[$handle] ?? 0) + 1;
                }
                continue;
            }

            if (isset(self::VALUE_MAPS[$targetHandle])
                && (is_string($value) || $value === null)
                && array_key_exists((string)$value, self::VALUE_MAPS[$targetHandle])) {
                $value = self::VALUE_MAPS[$targetHandle][(string)$value];
            }

            $out[$targetHandle] = $this->mapValue($target, $value);
        }

        return $out;
    }

    private function mapValue(FieldInterface $field, mixed $value): mixed
    {
        if ($field instanceof Matrix) {
            return $this->buildMatrix($field, $value);
        }

        if ($field instanceof \verbb\supertable\fields\SuperTableField) {
            return $this->buildSuperTable($field, $value);
        }

        if ($field instanceof BaseRelationField) {
            return $this->mapRelation($value);
        }

        if ($field instanceof \lenz\linkfield\fields\LinkField) {
            return $this->mapLink($value);
        }

        return $value;
    }

    private function buildMatrix(Matrix $field, mixed $value): array
    {
        if (!is_array($value)) {
            return [];
        }

        $byHandle = [];
        foreach ($field->getBlockTypes() as $bt) {
            $byHandle[$bt->handle] = $bt;
        }

        $out = [];
        $n = 0;

        foreach ($value as $block) {
            $handle = $block['type'] ?? null;
            if ($handle === null || !isset($byHandle[$handle])) {
                $this->warnings[] = "No target Matrix block type '{$handle}' on {$field->handle}.";
                continue;
            }

            $out['new' . ++$n] = [
                'type' => $handle,
                'enabled' => $block['enabled'] ?? true,
                'fields' => $this->mapFields(
                    $block['fields'] ?? [],
                    $byHandle[$handle]->getFieldLayout()?->getCustomFields() ?? []
                ),
            ];
        }

        return $out;
    }

    /**
     * Super Table keys blocks by block type *ID*, not handle - and there is only ever one.
     */
    private function buildSuperTable(\verbb\supertable\fields\SuperTableField $field, mixed $value): array
    {
        if (!is_array($value)) {
            return [];
        }

        $blockTypes = $field->getBlockTypes();
        if (empty($blockTypes)) {
            $this->warnings[] = "Super Table field '{$field->handle}' has no block type.";
            return [];
        }
        $blockType = $blockTypes[0];
        $layoutFields = $blockType->getFieldLayout()?->getCustomFields() ?? [];

        $out = [];
        $n = 0;

        foreach ($value as $block) {
            $out['new' . ++$n] = [
                'type' => $blockType->id,
                'fields' => $this->mapFields($block['fields'] ?? [], $layoutFields),
            ];
        }

        return $out;
    }

    private function mapRelation(mixed $value): array
    {
        if (!is_array($value)) {
            return [];
        }

        $ids = [];

        foreach ($value as $ref) {
            if (isset($ref['assetRef'])) {
                $target = $this->assetMap[$ref['assetRef']] ?? null;
                if ($target) {
                    $ids[] = $target;
                } else {
                    $this->warnings[] = sprintf(
                        'No target asset for source #%d (%s).',
                        $ref['assetRef'],
                        $ref['filename'] ?? '?'
                    );
                }
            } elseif (isset($ref['elementRef'])) {
                $mapped = self::LINK_REMAP[$ref['elementRef']] ?? null;
                if ($mapped) {
                    $ids[] = $mapped;
                } else {
                    $this->warnings[] = "Unmapped element relation #{$ref['elementRef']}.";
                }
            }
        }

        return $ids;
    }

    private function mapLink(mixed $value): ?array
    {
        if (!is_array($value) || empty($value['type'])) {
            return null;
        }

        $out = [
            'type' => $value['type'],
            'customText' => $value['customText'] ?? null,
            'target' => $value['target'] ?? '',
            'title' => $value['title'] ?? null,
            'ariaLabel' => $value['ariaLabel'] ?? null,
        ];

        if (!empty($value['elementRef'])) {
            // Decision 6b: the source page has no counterpart here.
            $mapped = self::LINK_REMAP[$value['elementRef']] ?? null;
            if ($mapped) {
                $out['linkedId'] = $mapped;
            } else {
                $this->warnings[] = sprintf(
                    'Link to source element #%d has no remapping; falling back to its URL.',
                    $value['elementRef']
                );
                $out['type'] = 'url';
                $out['linkedUrl'] = $value['url'] ?? null;
            }
        } elseif (!empty($value['url'])) {
            $out['linkedUrl'] = $value['url'];
        }

        return $out;
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private function resolveAuthorId(): ?int
    {
        $users = Craft::$app->getUsers();

        if ($this->author !== null) {
            $user = $users->getUserByUsernameOrEmail($this->author);
            if (!$user) {
                $this->stderr("No user matching '{$this->author}'.\n", Console::FG_RED);
                return null;
            }
            return $user->id;
        }

        $admin = \craft\elements\User::find()->admin()->status(null)->orderBy('elements.id')->one();

        return $admin?->id;
    }

    /**
     * @return array<string,Entry> normalized title => investigation
     */
    private function loadInvestigations(): array
    {
        $entries = Entry::find()
            ->section('investigations')
            ->type('investigationParent')
            ->level(1)
            ->status(null)
            ->siteId(Craft::$app->getSites()->getPrimarySite()->id)
            ->all();

        $out = [];
        foreach ($entries as $entry) {
            $out[$this->normalizeTitle($entry->title)] = $entry;
        }

        return $out;
    }

    /**
     * Source titles carry stray double spaces ("Coloring  the Universe").
     */
    private function normalizeTitle(string $title): string
    {
        return StringHelper::toLowerCase(trim(preg_replace('/\s+/u', ' ', $title)));
    }

    private function findField(ElementInterface $element, string $handle): ?FieldInterface
    {
        foreach ($element->getFieldLayout()?->getCustomFields() ?? [] as $field) {
            if ($field->handle === $handle) {
                return $field;
            }
        }
        return null;
    }

    private function isEmptyValue(mixed $value): bool
    {
        if ($value === null || $value === '' || $value === false || $value === []) {
            return true;
        }
        if (is_array($value)) {
            foreach ($value as $v) {
                if (!$this->isEmptyValue($v)) {
                    return false;
                }
            }
            return true;
        }
        return false;
    }

    private function sameBytes(Asset $asset, string $sha256): bool
    {
        try {
            $local = $asset->getCopyOfFile();
            $same = hash_file('sha256', $local) === $sha256;
            @unlink($local);
            return $same;
        } catch (\Throwable) {
            return false;
        }
    }

    private function bundleDir(): ?string
    {
        $dir = $this->bundle ?: Craft::getAlias('@storage/assessments-import');
        if (!is_dir($dir)) {
            $this->stderr("Bundle directory not found: $dir\n", Console::FG_RED);
            return null;
        }
        return rtrim($dir, '/');
    }

    private function readJson(string $path): array
    {
        if (!is_file($path)) {
            return [];
        }
        $data = json_decode(file_get_contents($path), true);
        return is_array($data) ? $data : [];
    }

    private function writeBundleJson(string $path, mixed $data): void
    {
        FileHelper::writeToFile($path, json_encode(
            $data,
            JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE
        ) . "\n");
    }

    private function reportWarnings(): void
    {
        if (empty($this->warnings)) {
            return;
        }

        $grouped = [];
        foreach ($this->warnings as $w) {
            $key = preg_replace('/#\d+/', '#N', $w);
            $grouped[$key] = ($grouped[$key] ?? 0) + 1;
        }

        $this->stdout(sprintf("\n%d warning(s), %d distinct:\n", count($this->warnings), count($grouped)), Console::FG_YELLOW);
        foreach ($grouped as $msg => $count) {
            $this->stdout(sprintf("  [x%d] %s\n", $count, mb_substr($msg, 0, 200)), Console::FG_YELLOW);
        }
        $this->stdout("\n");
    }
}
