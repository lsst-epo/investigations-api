<?php

namespace modules\investigations\models;

/**
 * Collapses repeated warnings into distinct messages with a count.
 */
class Warnings
{
    /**
     * @param string[] $warnings
     * @return array<int,array{message:string,count:int}>
     */
    public static function group(array $warnings): array
    {
        $grouped = [];

        foreach ($warnings as $warning) {
            $key = preg_replace('/#\d+/', '#N', $warning);
            $grouped[$key] = ($grouped[$key] ?? 0) + 1;
        }

        $out = [];
        foreach ($grouped as $message => $count) {
            $out[] = [
                'message' => mb_substr($message, 0, 200),
                'count' => $count,
            ];
        }

        return $out;
    }
}
