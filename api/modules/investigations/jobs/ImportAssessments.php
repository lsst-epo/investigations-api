<?php

namespace modules\investigations\jobs;

use Craft;
use craft\queue\BaseJob;
use modules\investigations\Module;

/**
 * Imports an assessments bundle into the Assessments channel.
 */
class ImportAssessments extends BaseJob
{
    public ?string $bundleDir = null;
    public bool $dryRun = false;
    public bool $allowMissingAssets = false;
    public ?string $author = null;

    /** Deletes the unpacked bundle when the run succeeds. */
    public bool $cleanup = false;

    /** Cache key the result is stored under for the utility to read back. */
    public string $resultKey = '';

    public function execute($queue): void
    {
        $service = Module::getInstance()->assessmentsImport;

        $result = $service->import(
            $this->bundleDir,
            $this->dryRun,
            $this->allowMissingAssets,
            $this->author,
            function(float $progress, string $label) use ($queue) {
                $this->setProgress($queue, $progress, $label);
            }
        );

        // A failed or partial run stays on disk so it can be inspected.
        if ($this->cleanup && !$this->dryRun && $result->ok && $result->error === '') {
            $service->cleanupBundle($this->bundleDir);
        }

        JobResults::store($this->resultKey, $result->toArray());
    }

    protected function defaultDescription(): ?string
    {
        return $this->dryRun
            ? Craft::t('app', 'Assessments import dry run')
            : Craft::t('app', 'Importing assessments');
    }
}
