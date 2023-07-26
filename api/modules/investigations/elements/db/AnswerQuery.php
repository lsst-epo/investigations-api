<?php

namespace modules\investigations\elements\db;

use Craft;
use craft\elements\db\ElementQuery;
use craft\helpers\Db;

/**
 * Answer query
 */
class AnswerQuery extends ElementQuery
{
    public $userId;
    public $questionId;
    public $data;

    public function userId($value): self
    {
        $this->userId = $value;
        return $this;
    }

    public function questionId($value): self
    {
        $this->questionId = $value;
        return $this;
    }

    public function data($value): self
    {
        $this->data = $value;
        return $this;
    }

    protected function beforePrepare(): bool
    {
        // JOIN our 'investigation_answers' table
        $this->joinElementTable('investigation_answers');

        // SELECT content columns:
        $this->query->select([
            'investigation_answers.userId',
            'investigation_answers.questionId',
            'investigation_answers.data'
        ]);

        if ($this->userId) {
            $this->subQuery->andWhere(Db::parseParam('investigation_answers.userId', $this->userId));
        }

        if ($this->questionId) {
            $this->subQuery->andWhere(Db::parseParam('investigation_answers.questionId', $this->questionId));
        }

        if ($this->data) {
            $this->subQuery->andWhere(Db::parseParam('investigation_answers.data', $this->data));
        }

        return parent::beforePrepare();
    }
}
