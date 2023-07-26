<?php

namespace modules\investigations\gql\resolvers\elements;

use craft\gql\base\ElementResolver;
use modules\investigations\elements\Answer as AnswerElement;

class Answer extends ElementResolver
{
    protected static function prepareQuery($source, array $arguments, ?string $fieldName = null): mixed
    {
        if($source === null) {
            $query = AnswerElement::find();
        } else {
            $query = $source->$fieldName;
        }

        if(is_array($query)) {
            return $query;
        }

        foreach($arguments as $key => $value) {
            if(method_exists($query, $key)) {
                $query->$key($value);
            } elseif(property_exists($query, $key)) {
                $query->$key = $value;
            } else {
                $query->$key($value);
            }
        }

        return $query;
    }

    public static function resolveType() {
        return \modules\investigations\gql\types\elements\Answer::class;
    }
}
