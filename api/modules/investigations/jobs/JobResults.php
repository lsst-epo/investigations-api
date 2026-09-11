<?php

namespace modules\investigations\jobs;

use Craft;

/**
 * Holds a finished job's result until the utility reads it back.
 */
class JobResults
{
    private const PREFIX = 'assessments-import:result:';
    private const TTL = 86400;

    public static function key(): string
    {
        return bin2hex(random_bytes(8));
    }

    public static function store(string $key, array $result): void
    {
        if ($key !== '') {
            Craft::$app->getCache()->set(self::PREFIX . $key, $result, self::TTL);
        }
    }

    public static function fetch(string $key): ?array
    {
        $result = Craft::$app->getCache()->get(self::PREFIX . $key);

        return is_array($result) ? $result : null;
    }
}
