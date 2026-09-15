<?php

namespace modules\investigations\services;

use Craft;
use craft\base\ElementInterface;
use craft\base\FieldInterface;
use craft\base\FsInterface;
use craft\elements\Asset;
use craft\elements\db\ElementQuery;
use craft\elements\Entry;
use craft\errors\InvalidElementException;
use craft\fields\BaseRelationField;
use craft\fields\Matrix;
use craft\flysystem\base\FlysystemFs;
use craft\helpers\FileHelper;
use craft\helpers\StringHelper;
use modules\investigations\models\AssetsResult;
use modules\investigations\models\ImportResult;
use yii\base\Component;

/**
 * Imports the assessments bundle produced by rubin-obs-api into the Assessments
 * channel.
 *
 * Maps the bundle onto the target field layouts by handle and reports anything
 * it cannot place. Callers drive this from the console controller or from the
 * queue jobs behind the Assessments Import utility.
 */
class AssessmentsImport extends Component
{
    /** Section the assessments land in. */
    private const SECTION = 'assessments';

    /** Entries field on Investigation Parent holding the hand-ordered assessments. */
    private const RELATED_FIELD = 'relatedAssessments';

    /** Default volume the migrated binaries land in. */
    private const VOLUME = 'assessmentAssets';

    /** Source handle => target handle. */
    private const FIELD_RENAMES = [
        'verticalAlignment' => 'verticalAlignnment',
    ];

    /** Field handle => source option value => target option value. */
    private const VALUE_MAPS = [
        'cellBackground' => ['' => 'none'],
    ];

    /** Source entry ID => target entry ID, for link blocks. */
    private const LINK_REMAP = [
        118692 => 604, // Coloring the Universe
    ];

    /** Files the bundle is expected to contain. */
    public const BUNDLE_RECORDS = 'assessments.json';
    public const BUNDLE_ASSET_INDEX = 'assets/index.json';
    public const BUNDLE_ASSET_MAP = 'asset-map.json';

    private bool $dryRun = false;

    /** Username or email to credit as author. Falls back to the first admin. */
    private ?string $author = null;

    private ?int $authorId = null;

    /** @var array<int,int> sourceAssetId => targetAssetId */
    private array $assetMap = [];

    /**
     * Assessments this run placed under each investigation, in bundle order.
     *
     * Entries created by a dry run have no ID yet and are recorded as null.
     *
     * @var array<int,array<int|null>> investigation entry ID => assessment entry IDs
     */
    private array $assessmentsByInvestigation = [];

    /** @var string[] */
    private array $warnings = [];

    /** @var array<string,int> */
    private array $droppedFields = [];

    /** @var callable|null */
    private $onProgress = null;

    /** @var callable|null */
    private $onNotice = null;

    /** @var string[] */
    private array $notices = [];

    // =========================================================================
    // Bundle
    // =========================================================================

    /**
     * Directory the bundle is unpacked into when no path is given.
     */
    public function defaultBundleDir(): string
    {
        return Craft::getAlias('@storage/assessments-import');
    }

    /**
     * Reports which bundle files are present, for driving the utility's steps.
     *
     * @return array{dir:string,exists:bool,records:int,assets:int,map:int}
     */
    public function bundleState(?string $dir = null): array
    {
        $dir = $this->bundleDir($dir);

        return [
            'dir' => $dir,
            'exists' => is_dir($dir),
            'records' => count($this->readJson($dir . '/' . self::BUNDLE_RECORDS)),
            'assets' => count($this->readJson($dir . '/' . self::BUNDLE_ASSET_INDEX)),
            'map' => count($this->readJson($dir . '/' . self::BUNDLE_ASSET_MAP)),
        ];
    }

    /**
     * Deletes the unpacked bundle, keeping asset-map.json.
     *
     * The map is the only durable record of source ref => asset ID; rebuilding it
     * by hash cannot match images Craft rewrote on upload.
     */
    public function cleanupBundle(?string $dir = null): void
    {
        $dir = $this->bundleDir($dir);
        if (!is_dir($dir)) {
            return;
        }

        foreach (new \DirectoryIterator($dir) as $item) {
            if ($item->isDot() || $item->getFilename() === self::BUNDLE_ASSET_MAP) {
                continue;
            }

            if ($item->isDir()) {
                FileHelper::removeDirectory($item->getPathname());
            } else {
                FileHelper::unlink($item->getPathname());
            }
        }
    }

    // =========================================================================
    // Assets
    // =========================================================================

    /**
     * Uploads the bundle's binaries into the target volume and writes asset-map.json.
     *
     * A file already in the volume's root folder with the same name and bytes is
     * reused, or indexed if Craft has no asset for it, instead of uploaded again.
     */
    public function uploadAssets(
        ?string $dir = null,
        ?string $volumeHandle = null,
        bool $dryRun = false,
        ?callable $onProgress = null,
        ?callable $onNotice = null
    ): AssetsResult {
        $this->reset($dryRun, null, $onProgress, $onNotice);

        $dir = $this->bundleDir($dir);
        if (!is_dir($dir)) {
            return AssetsResult::failed("Bundle directory not found: $dir");
        }

        $index = $this->readJson($dir . '/' . self::BUNDLE_ASSET_INDEX);
        if (empty($index)) {
            return AssetsResult::failed(
                'No usable assets/index.json in the bundle. Run the exporter with GCS credentials first.'
            );
        }

        $handle = $volumeHandle ?: self::VOLUME;
        $volume = Craft::$app->getVolumes()->getVolumeByHandle($handle);
        if (!$volume) {
            return AssetsResult::failed("Volume '$handle' not found.");
        }

        $result = new AssetsResult();
        $result->dryRun = $dryRun;
        $result->total = count($index);
        $result->volumeHandle = $handle;
        $result->volumeName = $volume->name;
        $result->fsDescription = $this->describeFs($volume);

        $this->notice(sprintf("Uploading into '%s' (%s).", $result->volumeName, $result->fsDescription));

        $folder = Craft::$app->getAssets()->getRootFolderByVolumeId($volume->id);
        $fs = $volume->getFs();
        $priorMap = array_map('intval', $this->readJson($dir . '/' . self::BUNDLE_ASSET_MAP));
        $map = [];
        $done = 0;
        $session = null;

        try {
            foreach ($index as $item) {
                $this->progress(++$done / $result->total, "Asset $done of {$result->total}");

                // Reuses the asset already recorded for this ref in asset-map.json.
                $priorId = $priorMap[$item['assetRef']] ?? null;
                if ($priorId) {
                    $prior = Asset::find()->id($priorId)->volumeId($volume->id)->status(null)->one();
                    if ($prior && $prior->filename === $item['filename']) {
                        $map[$item['assetRef']] = $prior->id;
                        $result->reused++;
                        continue;
                    }
                }

                $path = $dir . '/' . $item['file'];
                $uri = $folder->path . $item['filename'];

                // Matches an unmapped ref to an indexed asset at its upload location by bytes.
                $existing = Asset::find()
                    ->volumeId($volume->id)
                    ->folderId($folder->id)
                    ->filename($item['filename'])
                    ->status(null)
                    ->one();

                if ($existing) {
                    if ($this->sameBytes($fs, $existing->getPath(), $path, $item['sha256'])) {
                        $map[$item['assetRef']] = $existing->id;
                        $result->reused++;
                        continue;
                    }

                    $this->warnings[] = "{$item['filename']} already exists with different contents; uploading under a new name.";
                } else {
                    // Checks the volume for a file Craft has not indexed.
                    try {
                        $inVolume = $fs->fileExists($uri);
                    } catch (\Throwable $e) {
                        $this->warnings[] = "Could not check the volume for {$item['filename']}: {$e->getMessage()}";
                        continue;
                    }

                    if ($inVolume) {
                        if (!$this->sameBytes($fs, $uri, $path, $item['sha256'])) {
                            $this->warnings[] = "{$item['filename']} already exists with different contents; uploading under a new name.";
                        } elseif ($this->dryRun) {
                            $map[$item['assetRef']] = 0;
                            $result->indexed++;
                            continue;
                        } else {
                            $session ??= Craft::$app->getAssetIndexer()->createIndexingSession([$volume]);
                            $indexed = $this->indexVolumeFile($volume, $uri, $session->id, $item);
                            if ($indexed) {
                                $map[$item['assetRef']] = $indexed->id;
                                $result->indexed++;
                            }
                            // Leaves a ref that failed to index unmapped rather than uploading a second copy.
                            continue;
                        }
                    }
                }

                if (!is_file($path)) {
                    $this->warnings[] = "Bundle file missing: {$item['file']}";
                    continue;
                }

                if ($this->dryRun) {
                    $map[$item['assetRef']] = 0;
                    $result->uploaded++;
                    continue;
                }

                // Copies the bundle file to a temp path; saving the asset consumes it.
                $temp = Craft::$app->getPath()->getTempPath() . '/' . uniqid('assessment-', true)
                    . '.' . pathinfo($item['filename'], PATHINFO_EXTENSION);

                if (!copy($path, $temp)) {
                    $this->warnings[] = "Could not stage {$item['file']} for upload.";
                    continue;
                }

                $asset = new Asset();
                $asset->tempFilePath = $temp;
                $asset->setFilename($item['filename']);
                $asset->newFolderId = $folder->id;
                $asset->setVolumeId($volume->id);
                $asset->avoidFilenameConflicts = true;
                // Stores the bundle bytes as-is, so later runs can match them by checksum.
                $asset->sanitizeOnUpload = false;
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
                    @unlink($temp);
                    continue;
                }

                $map[$item['assetRef']] = $asset->id;
                $result->uploaded++;
            }
        } finally {
            if ($session !== null) {
                Craft::$app->getAssetIndexer()->stopIndexingSession($session);
            }
        }

        // Merges this run's refs into the existing map.
        if (!$this->dryRun) {
            $mapPath = $dir . '/' . self::BUNDLE_ASSET_MAP;
            $map += array_map('intval', $this->readJson($mapPath));
            $this->writeBundleJson($mapPath, $map);
        }

        $result->mapped = count($map);
        $result->notices = $this->notices;
        $result->warnings = $this->warnings;
        $result->ok = $result->mapped === $result->total;

        return $result;
    }

    /**
     * Describes a volume's filesystem for display.
     */
    public function describeFs($volume): string
    {
        $fs = $volume->getFs();

        if ($fs instanceof \craft\fs\Local) {
            return $fs->name . ', local: ' . $fs->getRootPath();
        }

        return $fs->name . ', ' . get_class($fs);
    }

    // =========================================================================
    // Import
    // =========================================================================

    public function import(
        ?string $dir = null,
        bool $dryRun = false,
        bool $allowMissingAssets = false,
        ?string $author = null,
        ?callable $onProgress = null,
        ?callable $onNotice = null
    ): ImportResult {
        $this->reset($dryRun, $author, $onProgress, $onNotice);

        $dir = $this->bundleDir($dir);
        if (!is_dir($dir)) {
            return ImportResult::failed("Bundle directory not found: $dir");
        }

        $records = $this->readJson($dir . '/' . self::BUNDLE_RECORDS);
        if (empty($records)) {
            return ImportResult::failed(self::BUNDLE_RECORDS . ' is empty or missing.');
        }

        $result = new ImportResult();
        $result->dryRun = $dryRun;

        $mapPath = $dir . '/' . self::BUNDLE_ASSET_MAP;
        if (is_file($mapPath)) {
            $this->assetMap = array_map('intval', $this->readJson($mapPath));
            $result->assetMapEntries = count($this->assetMap);
        } elseif (!$allowMissingAssets) {
            return ImportResult::failed(
                'No asset-map.json found. Upload the assets first, or allow missing assets '
                . 'to import content without file relations.'
            );
        }

        $section = Craft::$app->getSections()->getSectionByHandle(self::SECTION);
        if (!$section) {
            return ImportResult::failed("Section '" . self::SECTION . "' not found.");
        }
        $entryType = $section->getEntryTypes()[0];

        $this->authorId = $this->resolveAuthorId();
        if ($this->authorId === null) {
            return ImportResult::failed(
                $this->author !== null
                    ? "No user matching '{$this->author}'."
                    : 'Could not resolve an author. Name a username or email to credit.'
            );
        }
        $result->authorId = $this->authorId;

        $this->notice($result->assetMapEntries > 0
            ? sprintf('Asset map: %d entries.', $result->assetMapEntries)
            : 'No asset-map.json - asset relations will be skipped.');
        $this->notice(sprintf('Authoring as user #%d.', $this->authorId));

        $investigations = $this->loadInvestigations();
        $result->investigations = count($investigations);
        $this->notice(sprintf('Target investigations: %d.', $result->investigations));

        $primary = Craft::$app->getSites()->getPrimarySite();
        $total = count($records);
        $done = 0;

        foreach ($records as $record) {
            $this->progress(++$done / $total, "Record $done of $total");

            $outcome = $this->importRecord($record, $section, $entryType, $investigations, $primary);
            match ($outcome) {
                'created' => $result->created++,
                'updated' => $result->updated++,
                default => $result->failed++,
            };
        }

        $this->linkAssessments($investigations, $result);

        $result->droppedFields = $this->droppedFields;
        $result->notices = $this->notices;
        $result->warnings = $this->warnings;
        $result->ok = $result->failed === 0;

        return $result;
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

        // Matches the investigation by normalized title.
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

        // Prefixes the slug with the target investigation's slug.
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
        // postDate is stamped at import.

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
            $this->recordAssessment($investigation, $entry);
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

        $this->recordAssessment($investigation, $entry);
        $this->applyOtherSites($entry, $record, $slug, $investigation, $primary);

        return $isNew ? 'created' : 'updated';
    }

    // =========================================================================
    // Ordered relations on the investigation
    // =========================================================================

    /**
     * Queues an imported assessment for the investigation's ordered Entries field.
     */
    private function recordAssessment(?Entry $investigation, Entry $assessment): void
    {
        if ($investigation === null) {
            return;
        }

        $this->assessmentsByInvestigation[$investigation->id][] = $assessment->id;
    }

    /**
     * Writes the hand-ordered Entries field on every investigation this run touched.
     *
     * investigationEntry points from the assessment at its investigation, and the
     * Many to Many field used to derive the other side from it. Now that editors
     * order the relations by hand, the investigation side is its own field and
     * nothing maintains it, so the import writes it here: relations already on the
     * entry keep their order, and assessments not yet related are appended in
     * bundle order.
     *
     * @param array<string,Entry> $investigations normalized title => investigation
     */
    private function linkAssessments(array $investigations, ImportResult $result): void
    {
        if (empty($this->assessmentsByInvestigation)) {
            return;
        }

        $byId = [];
        foreach ($investigations as $investigation) {
            $byId[$investigation->id] = $investigation;
        }

        foreach ($this->assessmentsByInvestigation as $investigationId => $assessmentIds) {
            $investigation = $byId[$investigationId] ?? null;
            if (!$investigation) {
                continue;
            }

            if (!$this->findField($investigation, self::RELATED_FIELD)) {
                $this->warnings[] = sprintf(
                    "No '%s' field on the Investigation Parent layout; \"%s\" was left alone.",
                    self::RELATED_FIELD,
                    $investigation->title
                );
                continue;
            }

            $existing = $this->existingRelations($investigation, self::RELATED_FIELD);

            // A dry run has no IDs for the entries it would create; each is a relation.
            $pending = count(array_filter($assessmentIds, fn($id) => $id === null));
            $saved = array_values(array_unique(array_filter($assessmentIds)));

            $ordered = array_merge($existing, array_values(array_diff($saved, $existing)));
            $added = count($ordered) - count($existing) + $pending;

            if ($added === 0) {
                continue;
            }

            $result->relationsAdded += $added;
            $result->investigationsLinked++;

            if ($this->dryRun) {
                continue;
            }

            $investigation->setFieldValue(self::RELATED_FIELD, $ordered);

            if (!Craft::$app->getElements()->saveElement($investigation)) {
                $this->warnings[] = sprintf(
                    'Could not write %s on "%s": %s',
                    self::RELATED_FIELD,
                    $investigation->title,
                    json_encode($investigation->getErrors())
                );
            }
        }
    }

    /**
     * The element IDs already related through $handle, in their stored order.
     *
     * Disabled targets count: they are dropped from the field otherwise.
     *
     * @return int[]
     */
    private function existingRelations(ElementInterface $element, string $handle): array
    {
        try {
            $value = $element->getFieldValue($handle);
        } catch (\Throwable) {
            return [];
        }

        if ($value instanceof ElementQuery) {
            return array_map('intval', (clone $value)->status(null)->limit(null)->ids());
        }

        $ids = [];
        foreach (is_iterable($value) ? $value : [] as $related) {
            if ($related instanceof ElementInterface && $related->id) {
                $ids[] = (int)$related->id;
            }
        }

        return $ids;
    }

    /**
     * Writes the non-primary locales and disables any with no source content.
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
                // No source content for this locale.
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
     * site, reusing their existing block IDs.
     *
     * Returns null when the propagated structure doesn't line up with the source.
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

        // Neo honors existing block IDs only in this delta format.
        return ['sortOrder' => $sortOrder, 'blocks' => $blocks];
    }

    /**
     * mapFields() for a non-primary site.
     *
     * Recurses into every container and includes leaf fields only when they are
     * translatable.
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
                // Counted on the primary pass.
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

            // Every existing block stays in the payload, keyed in sort order.
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
     * Super Table keys blocks by block type ID, not handle.
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
            // Remaps the source element reference, or falls back to its URL.
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
            return $users->getUserByUsernameOrEmail($this->author)?->id;
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
     * Lowercases the title, trims it, and collapses runs of whitespace.
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

    /**
     * Whether the file at $uri in the volume holds the same bytes as the bundle file.
     *
     * Compares the MD5 the filesystem reports (GCS keeps it in object metadata) and
     * streams the file only when no checksum is available.
     */
    private function sameBytes(FsInterface $fs, string $uri, string $localPath, string $sha256): bool
    {
        try {
            $checksum = is_file($localPath) ? $this->fsChecksum($fs, $uri) : null;
            if ($checksum !== null) {
                return hash_equals($checksum, md5_file($localPath));
            }

            $stream = $fs->getFileStream($uri);
            $context = hash_init('sha256');
            hash_update_stream($context, $stream);
            fclose($stream);

            return hash_equals($sha256, hash_final($context));
        } catch (\Throwable) {
            return false;
        }
    }

    /**
     * The MD5 checksum the filesystem stores for $uri, or null when it has none.
     */
    private function fsChecksum(FsInterface $fs, string $uri): ?string
    {
        if (!$fs instanceof FlysystemFs) {
            return null;
        }

        try {
            // Craft keeps the Flysystem instance protected.
            $filesystem = \Closure::bind(fn() => $this->filesystem(), $fs, FlysystemFs::class)();
            return $filesystem->checksum($uri, ['checksum_algo' => 'md5']);
        } catch (\Throwable) {
            // Composite GCS objects carry no MD5.
            return null;
        }
    }

    /**
     * Creates the asset for a file already in the volume, without uploading it.
     */
    private function indexVolumeFile($volume, string $uri, int $sessionId, array $item): ?Asset
    {
        try {
            $asset = Craft::$app->getAssetIndexer()->indexFile($volume, $uri, $sessionId);
        } catch (\Throwable $e) {
            $this->warnings[] = sprintf('Could not index %s: %s', $uri, $e->getMessage());
            return null;
        }

        // indexFile() logs a failed save instead of throwing.
        if (!$asset->id) {
            $this->warnings[] = "Could not index $uri.";
            return null;
        }

        if (!empty($item['alt']) && !$asset->alt) {
            $asset->alt = $item['alt'];
            Craft::$app->getElements()->saveElement($asset);
        }

        return $asset;
    }

    private function bundleDir(?string $dir): string
    {
        return rtrim($dir ?: $this->defaultBundleDir(), '/');
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

    /**
     * Clears per-run state.
     */
    private function reset(bool $dryRun, ?string $author, ?callable $onProgress, ?callable $onNotice): void
    {
        $this->dryRun = $dryRun;
        $this->author = $author;
        $this->onProgress = $onProgress;
        $this->onNotice = $onNotice;
        $this->authorId = null;
        $this->assetMap = [];
        $this->assessmentsByInvestigation = [];
        $this->warnings = [];
        $this->droppedFields = [];
        $this->notices = [];
    }

    /**
     * Records a line describing the run as it starts, before per-item progress.
     */
    private function notice(string $message): void
    {
        $this->notices[] = $message;

        if ($this->onNotice !== null) {
            ($this->onNotice)($message);
        }
    }

    private function progress(float $progress, string $label): void
    {
        if ($this->onProgress !== null) {
            ($this->onProgress)($progress, $label);
        }
    }
}
