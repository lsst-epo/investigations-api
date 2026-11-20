<?php

namespace modules\userregistrationmodule\jobs;

use Craft;
use craft\helpers\Template;
use craft\queue\BaseJob;
use yii\base\Exception;
use yii\queue\RetryableJobInterface;

/**
 * Sends an account activation email, retrying on failure.
 */
class SendActivationEmail extends BaseJob implements RetryableJobInterface
{
    public const MAX_ATTEMPTS = 5;

    public ?int $userId = null;
    public ?string $link = null;
    public ?string $language = null;

    public function execute($queue): void
    {
        $user = Craft::$app->getUsers()->getUserById($this->userId);

        if (!$user || !$user->pending) {
            return;
        }

        $message = Craft::$app->getMailer()
            ->composeFromKey('account_activation', ['link' => Template::raw($this->link)])
            ->setTo($user);

        if ($this->language) {
            $message->language = $this->language;
        }

        if (!$message->send()) {
            throw new Exception("Failed to send activation email to user {$this->userId}.");
        }
    }

    public function getTtr(): int
    {
        return 300;
    }

    public function canRetry($attempt, $error): bool
    {
        return $attempt < self::MAX_ATTEMPTS;
    }

    protected function defaultDescription(): ?string
    {
        return Craft::t('app', 'Sending activation email');
    }
}
