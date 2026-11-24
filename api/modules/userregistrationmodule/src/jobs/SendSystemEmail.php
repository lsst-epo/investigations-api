<?php

namespace modules\userregistrationmodule\jobs;

use Craft;
use craft\helpers\Template;
use craft\queue\BaseJob;
use yii\base\Exception;
use yii\queue\RetryableJobInterface;

/**
 * Sends a system message email to a user, retrying on failure.
 */
class SendSystemEmail extends BaseJob implements RetryableJobInterface
{
    public const MAX_ATTEMPTS = 5;

    public ?string $key = null;
    public ?int $userId = null;
    public array $variables = [];
    public ?string $language = null;

    /** Skip sending if the user is no longer pending. */
    public bool $requirePending = false;

    public function execute($queue): void
    {
        $user = Craft::$app->getUsers()->getUserById($this->userId);

        if (!$user || ($this->requirePending && !$user->pending)) {
            return;
        }

        $variables = array_map(fn($value) => Template::raw((string)$value), $this->variables);

        $message = Craft::$app->getMailer()
            ->composeFromKey($this->key, $variables)
            ->setTo($user);

        if ($this->language) {
            $message->language = $this->language;
        }

        if (!$message->send()) {
            throw new Exception("Failed to send {$this->key} email to user {$this->userId}.");
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
        return Craft::t('app', 'Sending {key} email', ['key' => $this->key]);
    }
}
