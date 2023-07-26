<?php

namespace modules\investigations\gql\types\generators;

use craft\gql\base\Generator;
use craft\gql\base\GeneratorInterface;
use craft\gql\base\ObjectType;
use craft\gql\GqlEntityRegistry;
use modules\investigations\elements\Answer as AnswerElement;
use modules\investigations\gql\interfaces\elements\Answer as AnswerInterface;
use modules\investigations\gql\types\elements\Answer;

class AnswerType extends Generator implements GeneratorInterface
{
    public static function generateTypes(mixed $context = null): array
    {
        $type = static::generateType($context);
        return [$type->name => $type];
    }

    public static function generateType(mixed $context): ObjectType
    {
        $context = $context ?: \Craft::$app->getFields()->getLayoutByType(AnswerElement::class);

        $typeName = AnswerElement::gqlTypeNameByContext(null);
        $contentFieldGqlTypes = self::getContentFields($context);
        $addressFields = array_merge(AnswerInterface::getFieldDefinitions(), $contentFieldGqlTypes);

        return GqlEntityRegistry::getEntity($typeName) ?: GqlEntityRegistry::createEntity($typeName, new Answer([
            'name' => $typeName,
            'fields' => function() use ($addressFields, $typeName) {
                return \Craft::$app->getGql()->prepareFieldDefinitions($addressFields, $typeName);
            },
        ]));
    }
}
