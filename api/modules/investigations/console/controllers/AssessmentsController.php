<?php

namespace modules\investigations\console\controllers;

use craft\console\Controller;
use craft\helpers\Console;
use modules\investigations\models\AssetsResult;
use modules\investigations\models\ImportResult;
use modules\investigations\models\Warnings;
use modules\investigations\Module;
use yii\console\ExitCode;

/**
 * Imports the assessments bundle produced by rubin-obs-api into the Assessments
 * channel.
 *
 * Wraps modules\investigations\services\AssessmentsImport, which the Assessments
 * Import utility drives from the Control Panel.
 *
 * Usage:
 *   php craft investigations/assessments/upload-assets --bundle=/path/to/bundle
 *   php craft investigations/assessments/upload-assets --bundle=/path/to/bundle --volume=testVolume
 *   php craft investigations/assessments/import --bundle=/path/to/bundle --dry-run
 *   php craft investigations/assessments/import --bundle=/path/to/bundle
 */
class AssessmentsController extends Controller
{
    public ?string $bundle = null;
    public bool $dryRun = false;
    public bool $allowMissingAssets = false;

    /** Volume handle to upload into. Defaults to the service's own default. */
    public ?string $volume = null;

    /** Username or email to credit as author. Defaults to the first admin. */
    public ?string $author = null;

    public function options($actionID): array
    {
        return array_merge(parent::options($actionID), [
            'bundle',
            'dryRun',
            'allowMissingAssets',
            'author',
            'volume',
        ]);
    }

    /**
     * Uploads the bundle's binaries into the target volume and writes asset-map.json.
     */
    public function actionUploadAssets(): int
    {
        $result = Module::getInstance()->assessmentsImport->uploadAssets(
            $this->bundle,
            $this->volume,
            $this->dryRun,
            fn(float $progress, string $label) => $this->stdout(sprintf("\r  %s", $label)),
            fn(string $notice) => $this->stdout(
                $notice . "\n",
                $this->volume ? Console::FG_YELLOW : Console::FG_GREY
            )
        );

        if ($result->error !== '') {
            $this->stderr($result->error . "\n", Console::FG_RED);
            return ExitCode::UNSPECIFIED_ERROR;
        }

        $this->stdout("\n");
        $this->stdout($result->summary() . "\n", Console::FG_GREEN);

        if (!$result->dryRun) {
            $this->stdout(sprintf("Wrote asset-map.json (%d entries).\n", $result->mapped), Console::FG_GREEN);
        }

        $this->reportWarnings($result->warnings);

        return $result->ok ? ExitCode::OK : ExitCode::UNSPECIFIED_ERROR;
    }

    public function actionImport(): int
    {
        $result = Module::getInstance()->assessmentsImport->import(
            $this->bundle,
            $this->dryRun,
            $this->allowMissingAssets,
            $this->author,
            fn(float $progress, string $label) => $this->stdout(sprintf("\r  %s", $label)),
            fn(string $notice) => $this->stdout($notice . "\n")
        );

        if ($result->error !== '') {
            $this->stderr($result->error . "\n", Console::FG_RED);
            return ExitCode::UNSPECIFIED_ERROR;
        }

        $this->stdout("\n");
        $this->stdout($result->summary() . "\n", $result->failed ? Console::FG_YELLOW : Console::FG_GREEN);

        if ($result->droppedFields) {
            $this->stdout("\nSource fields with no target counterpart:\n", Console::FG_YELLOW);
            foreach ($result->droppedFields as $handle => $count) {
                $this->stdout(sprintf("  %-28s %d value(s) with content\n", $handle, $count), Console::FG_YELLOW);
            }
        }

        $this->reportWarnings($result->warnings);

        return $result->ok ? ExitCode::OK : ExitCode::UNSPECIFIED_ERROR;
    }

    /**
     * @param string[] $warnings
     */
    private function reportWarnings(array $warnings): void
    {
        if (empty($warnings)) {
            return;
        }

        $grouped = Warnings::group($warnings);

        $this->stdout(sprintf(
            "\n%d warning(s), %d distinct:\n",
            count($warnings),
            count($grouped)
        ), Console::FG_YELLOW);

        foreach ($grouped as $warning) {
            $this->stdout(sprintf("  [x%d] %s\n", $warning['count'], $warning['message']), Console::FG_YELLOW);
        }

        $this->stdout("\n");
    }
}
