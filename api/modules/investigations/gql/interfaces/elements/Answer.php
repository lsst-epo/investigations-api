<?php namespace modules\investigations\gql\interfaces\elements;

use craft\gql\GqlEntityRegistry;
use craft\gql\interfaces\Element;
use craft\services\Gql;
use GraphQL\Type\Definition\InterfaceType;
use GraphQL\Type\Definition\Type;
use modules\investigations\gql\types\generators\AnswerType;

class Answer extends Element
{
    public static function getName(): string
    {
        return 'AnswerInterface';
    }

    public static function getType(): Type
    {
        if($type = GqlEntityRegistry::getEntity(self::getName())) {
            return $type;
        }

        $type = GqlEntityRegistry::createEntity(self::getName(), new InterfaceType([
            'name' => static::getName(),
            'fields' => self::class . '::getFieldDefinitions',
            'description' => 'The interface implemented by all answers.',
            'resolveType' => self::class . '::resolveElementTypeName'
        ]));

        AnswerType::generateTypes();

        return $type;
    }

    public static function getFieldDefinitions(): array
    {
        return (new Gql)->prepareFieldDefinitions(array_merge(
            parent::getFieldDefinitions(),
            [
                'userId' => [
                    'name' => 'userId',
                    'type' => Type::int(),
                    'description' => 'ID of the user answering the question'
                ],
                'questionId' => [
                    'name' => 'questionId',
                    'type' => Type::int(),
                    'description' => 'ID of the question being answered'
                ],
                'data' => [
                    'name' => 'data',
                    'type' => Type::string(),
                    'description' => 'Content of the user\'s answer'
                ]
            ]
        ), self::getName());
    }
}
