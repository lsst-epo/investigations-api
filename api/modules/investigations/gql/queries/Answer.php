<?php

namespace modules\investigations\gql\queries;

use craft\gql\base\Query;
use GraphQL\Type\Definition\Type;
use modules\investigations\gql\helpers\Gql as GqlHelper;
use modules\investigations\gql\interfaces\elements\Answer as AnswerInterface;
use modules\investigations\gql\arguments\elements\Answer as AnswerArguments;
use modules\investigations\gql\resolvers\elements\Answer as AnswerResolver;

class Answer extends Query
{
    public static function getQueries(bool $checkToken = true): array
    {
        if(!GqlHelper::canQueryAnswers()) {
            return [];
        }

        return [
            'answers' => [
                'type' => Type::listOf(AnswerInterface::getType()),
                'args' => AnswerArguments::getArguments(),
                'resolve' => AnswerResolver::class . '::resolve',
                'description' => 'This query is used to collect a user\'s Investigation answers.'
            ]
        ];
    }
}
