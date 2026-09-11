<?php

namespace modules\investigations\models;

/**
 * Outcome of an asset upload run.
 */
class AssetsResult
{
    public bool $ok = false;
    public bool $dryRun = false;

    /** Fatal error that stopped the run before it started. */
    public string $error = '';

    public string $volumeHandle = '';
    public string $volumeName = '';
    public string $fsDescription = '';

    public int $uploaded = 0;
    public int $reused = 0;

    /** Refs resolved to an asset ID. */
    public int $mapped = 0;

    /** Refs listed in assets/index.json. */
    public int $total = 0;

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
        return sprintf('%d uploaded, %d already present.', $this->uploaded, $this->reused);
    }

    public function toArray(): array
    {
        return [
            'ok' => $this->ok,
            'dryRun' => $this->dryRun,
            'error' => $this->error,
            'volumeHandle' => $this->volumeHandle,
            'volumeName' => $this->volumeName,
            'fsDescription' => $this->fsDescription,
            'uploaded' => $this->uploaded,
            'reused' => $this->reused,
            'mapped' => $this->mapped,
            'total' => $this->total,
            'summary' => $this->summary(),
            'notices' => $this->notices,
            'warnings' => Warnings::group($this->warnings),
        ];
    }
}
