<?php

namespace modules\investigations\models;

/**
 * Outcome of an import run.
 */
class ImportResult
{
    public bool $ok = false;
    public bool $dryRun = false;

    /** Fatal error that stopped the run before it started. */
    public string $error = '';

    public int $assetMapEntries = 0;
    public ?int $authorId = null;
    public int $investigations = 0;

    public int $created = 0;
    public int $updated = 0;
    public int $failed = 0;

    /** @var array<string,int> source handle => count of dropped values with content */
    public array $droppedFields = [];

    /** @var string[] Lines describing the run, emitted before per-item progress. */
    public array $notices = [];

    /** @var string[] */
    public array $warnings = [];

    public static function failed(string $error): self
    {
        $result = new self();
        $result->error = $error;

        return $result;
    }

    public function summary(): string
    {
        return sprintf(
            '%s: %d created, %d updated, %d failed.',
            $this->dryRun ? 'Dry run' : 'Import',
            $this->created,
            $this->updated,
            $this->failed
        );
    }

    public function toArray(): array
    {
        return [
            'ok' => $this->ok,
            'dryRun' => $this->dryRun,
            'error' => $this->error,
            'assetMapEntries' => $this->assetMapEntries,
            'authorId' => $this->authorId,
            'investigations' => $this->investigations,
            'created' => $this->created,
            'updated' => $this->updated,
            'failed' => $this->failed,
            'droppedFields' => $this->droppedFields,
            'summary' => $this->summary(),
            'notices' => $this->notices,
            'warnings' => Warnings::group($this->warnings),
        ];
    }
}
