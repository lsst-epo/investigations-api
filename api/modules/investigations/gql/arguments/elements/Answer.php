<?php

namespace modules\investigations\gql\arguments\elements;

use craft\gql\base\ElementArguments;
use GraphQL\Type\Definition\Type;

class Answer extends ElementArguments
{
    public static function getArguments(): array
    {
        return array_merge(parent::getArguments(), self::getContentArguments(), [
            'userId' => [
                'name' => 'userId',
                'type' => Type::id(),
                'description' => 'Narrows query results based on the authenticated user.'
            ],
            'investigationID' => [
                'name' => 'investigationId',
                'type' => Type::id(),
                'description' => 'Narrows query results based on the Investigation.'
            ]
        ]);
    }
}
