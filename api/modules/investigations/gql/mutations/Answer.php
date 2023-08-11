<?php

namespace modules\investigations\gql\mutations;

use craft\gql\base\Mutation;
use GraphQL\Type\Definition\Type;
use modules\investigations\gql\resolvers\mutations\Answer as AnswerMutationResolver;
use modules\investigations\gql\interfaces\elements\Answer as AnswerInterface;

class Answer extends Mutation
{
    public static function getMutations(): array
    {
        $mutations = [];

        $resolver = \Craft::createObject(AnswerMutationResolver::class);

        $mutations['createAnswer'] = [
            'name' => 'createAnswer',
            'args' => [
                'userId' => Type::nonNull(Type::int()),
                'questionId' => Type::nonNull(Type::int()),
                'investigationId' => Type::nonNull(Type::int()),
                'data' => Type::string()
            ],
            'resolve' => [$resolver, 'saveAnswer'],
            'description' => 'Saves a new answer',
            'type' => AnswerInterface::getType(),
        ];

        $mutations['saveAnswer'] = [
            'name' => 'saveAnswer',
            'args' => [
                'id' => Type::nonNull(Type::int()),
                'data' => Type::string()
            ],
            'resolve' => [$resolver, 'saveAnswer'],
            'description' => 'Saves an existing answer',
            'type' => AnswerInterface::getType()
        ];

        return $mutations;
    }
}
