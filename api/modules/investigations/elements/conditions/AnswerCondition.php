<?php

namespace modules\investigations\elements\conditions;

use Craft;
use craft\elements\conditions\ElementCondition;

/**
 * Answer condition
 */
class AnswerCondition extends ElementCondition
{
    protected function conditionRuleTypes(): array
    {
        return array_merge(parent::conditionRuleTypes(), [
            // ...
        ]);
    }
}
