<?php

namespace modules\investigations\gql\helpers;

class Gql extends \craft\helpers\Gql
{
    public static function canQueryAnswers(): bool
    {
        $allowedEntities = self::extractAllowedEntitiesFromSchema();
        return isset($allowedEntities['answers']);
    }

    public static function canMutateAnswers(): bool
    {
        $allowedEntities = self::extractAllowedEntitiesFromSchema();
        return isset($allowedEntities['answers']);
    }
}
