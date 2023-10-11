<?php

namespace modules\investigations\gql\types\input;

use craft\gql\GqlEntityRegistry;
use GraphQL\Type\Definition\InputObjectType;
use GraphQL\Type\Definition\Type;

class Answer extends InputObjectType
{
    /**
     * @return mixed
     */
    public static function getType(): mixed
    {
        $typeName = 'AnswerInput';

        return GqlEntityRegistry::getOrCreate($typeName, fn() => new InputObjectType([
            'name' => $typeName,
            'fields' => [
                'id' => [
                    'name' => 'id',
                    'type' => Type::id(),
                    'description' => 'The ID of the Answer element, if it exists.',
                ],
                'questionId' => [
                    'name' => 'questionId',
                    'type' => Type::id(),
                    'description' => 'The ID of the associated Question entry.',
                ],
                'data' => [
                    'name' => 'data',
                    'type' => Type::string(),
                    'description' => 'The data submitted by the user.',
                ],
            ],
        ]));
    }
}