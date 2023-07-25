<?php

namespace modules\investigations\elements\db;

use Craft;
use craft\elements\db\ElementQuery;

/**
 * Answer query
 */
class AnswerQuery extends ElementQuery
{
    public $user;
    public $question;
    public $data;

    public function user($value): self
    {
        $this->user = $value;
        return $this;
    }

    public function question($value): self
    {
        $this->question = $value;
        return $this;
    }

    public function data($value): self
    {
        $this->data = $value;
        return $this;
    }

    protected function beforePrepare(): bool
    {
        // JOIN our 'answers' table
        $this->joinElementTable('answers');

        // SELECT the `user` and `question` columns:
        $this->query->select([
            'answers.user',
            'answers.question',
            'answers.data'
        ]);

        if ($this->user) {
            $this->subQuery->andWhere(Db::parseParam('answers.user', $this->user));
        }

        if ($this->question) {
            $this->subQuery->andWhere(Db::parseParam('answers.question', $this->question));
        }

        if ($this->data) {
            $this->subQuery->andWhere(Db::parseParam('answers.data', $this->data));
        }

        return parent::beforePrepare();
    }
}
