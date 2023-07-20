<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;

/**
 * m230719_230939_create_answers_table migration.
 */
class m230719_230939_create_answers_table extends Migration
{
    /**
     * @inheritdoc
     */
    public function safeUp(): bool
    {
        // Create the Answers table:
        $this->createTable('investigation_answers', [
            'id' => $this->primaryKey(),
            'question' => $this->integer()->notNull(),
            'user' => $this->integer()->notNull(),
            'data' => $this->string(),
            'dateCreated' => $this->dateTime()->notNull(),
            'dateUpdated' => $this->dateTime()->notNull(),
            'uid' => $this->uid()
        ]);

        // Give it a foreign key to the elements table:
        $this->addForeignKey(
            null,
            'investigation_answers',
            'id',
            '{{%elements}}',
            'id',
            'CASCADE',
            null
        );

        return true;
    }

    /**
     * @inheritdoc
     */
    public function safeDown(): bool
    {
        echo "m230719_230939_create_answers_table cannot be reverted.\n";
        return false;
    }
}
