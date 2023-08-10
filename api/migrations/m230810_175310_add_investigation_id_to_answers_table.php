<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;

/**
 * m230810_175310_add_investigation_id_to_answers_table migration.
 */
class m230810_175310_add_investigation_id_to_answers_table extends Migration
{
    /**
     * @inheritdoc
     */
    public function safeUp(): bool
    {
        $this->addColumn('investigation_answers', 'investigationId', $this->integer()->notNull());

        return true;
    }

    /**
     * @inheritdoc
     */
    public function safeDown(): bool
    {
        $this->dropColumn('investigation_answers', 'investigationId');

        return true;
    }
}
