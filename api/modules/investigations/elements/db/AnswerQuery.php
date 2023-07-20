<?php

namespace modules\investigations\elements\db;

use Craft;
use craft\elements\db\ElementQuery;

/**
 * Answer query
 */
class AnswerQuery extends ElementQuery
{
    protected function beforePrepare(): bool
    {
        // todo: join the `answers` table
        // $this->joinElementTable('answers');

        // todo: apply any custom query params
        // ...

        return parent::beforePrepare();
    }
}
