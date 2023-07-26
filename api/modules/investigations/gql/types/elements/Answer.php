<?php

namespace modules\investigations\gql\types\elements;

use craft\gql\types\elements\Element;
use modules\investigations\gql\interfaces\elements\Answer as AnswerInterface;

class Answer extends Element
{
    public function __construct(array $config)
    {
        $config['interfaces'] = [
            AnswerInterface::getType(),
        ];

        parent::__construct($config);
    }
}
