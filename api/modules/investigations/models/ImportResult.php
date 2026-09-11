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

    /** Assessments appended to an investigation's ordered Assessments field. */
    public int $relationsAdded = 0;

    /** Investigations whose ordered Assessments field the run changed. */
    public int $investigationsLinked = 0;

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
        $summary = sprintf(
            '%s: %d created, %d updated, %d failed.',
            $this->dryRun ? 'Dry run' : 'Import',
            $this->created,
            $this->updated,
            $this->failed
        );

        if ($this->relationsAdded > 0) {
            $summary .= sprintf(
                ' %s %d assessment(s) to the ordered field on %d investigation(s).',
                $this->dryRun ? 'Would add' : 'Added',
                $this->relationsAdded,
                $this->investigationsLinked
            );
        }

        return $summary;
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
            'relationsAdded' => $this->relationsAdded,
            'investigationsLinked' => $this->investigationsLinked,
            'droppedFields' => $this->droppedFields,
            'summary' => $this->summary(),
            'notices' => $this->notices,
            'warnings' => Warnings::group($this->warnings),
        ];
    }
}
