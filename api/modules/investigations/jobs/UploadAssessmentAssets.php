<?php

namespace modules\investigations\jobs;

use Craft;
use craft\queue\BaseJob;
use modules\investigations\Module;

/**
 * Uploads an assessments bundle's binaries into a volume.
 */
class UploadAssessmentAssets extends BaseJob
{
    public ?string $bundleDir = null;
    public ?string $volumeHandle = null;
    public bool $dryRun = false;

    /** Cache key the result is stored under for the utility to read back. */
    public string $resultKey = '';

    public function execute($queue): void
    {
        $service = Module::getInstance()->assessmentsImport;

        $result = $service->uploadAssets(
            $this->bundleDir,
            $this->volumeHandle,
            $this->dryRun,
            function(float $progress, string $label) use ($queue) {
                $this->setProgress($queue, $progress, $label);
            }
        );

        JobResults::store($this->resultKey, $result->toArray());
    }

    protected function defaultDescription(): ?string
    {
        return Craft::t('app', 'Uploading assessment assets');
    }
}
