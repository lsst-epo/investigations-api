<?php

namespace modules\userregistrationmodule\elements\actions;

use Craft;
use craft\base\ElementAction;
use craft\elements\db\ElementQueryInterface;
use craft\elements\User;
use modules\userregistrationmodule\UserRegistrationModule;

/**
 * Approves the selected pending educators, emailing each an activation link.
 */
class ApproveEducators extends ElementAction
{
    public function getTriggerLabel(): string
    {
        return Craft::t('app', 'Approve educators');
    }

    public function getConfirmationMessage(): ?string
    {
        return Craft::t('app', 'Approve the selected educators? Each will be emailed a link to activate their account.');
    }

    public function performAction(ElementQueryInterface $query): bool
    {
        $module = UserRegistrationModule::$instance;
        $elements = Craft::$app->getElements();
        $approved = $skipped = $failed = 0;

        /** @var User $user */
        foreach ($query->status(null)->all() as $user) {
            if (!$user->pending || !$module->isEducator($user) || $module->isApproved($user)) {
                $skipped++;
                continue;
            }

            $user->setFieldValue('educatorApproved', true);

            if ($elements->saveElement($user)) {
                $approved++;
            } else {
                $failed++;
            }
        }

        $message = Craft::t('app', 'Approved {count, plural, =1{# educator} other{# educators}}.', ['count' => $approved]);

        if ($skipped) {
            $message .= ' ' . Craft::t('app', 'Skipped {count, plural, =1{# user who isn’t a pending, unapproved educator} other{# users who aren’t pending, unapproved educators}}.', ['count' => $skipped]);
        }

        if ($failed) {
            $message .= ' ' . Craft::t('app', 'Couldn’t save {count, plural, =1{# educator} other{# educators}}.', ['count' => $failed]);
        }

        $this->setMessage($message);

        return $failed === 0;
    }
}
