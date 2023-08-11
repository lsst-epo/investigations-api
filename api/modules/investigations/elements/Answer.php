<?php

namespace modules\investigations\elements;

use Craft;
use craft\base\Element;
use craft\elements\User;
use craft\elements\conditions\ElementConditionInterface;
use craft\elements\db\ElementQueryInterface;
use craft\helpers\Db;
use craft\helpers\UrlHelper;
use craft\web\CpScreenResponseBehavior;
use modules\investigations\elements\conditions\AnswerCondition;
use modules\investigations\elements\db\AnswerQuery;
use yii\web\Response;

/**
 * Answer element type
 */
class Answer extends Element
{
    public ?int $questionId = null;
    public ?int $userId = null;
    public ?int $investigationId = null;
    public ?string $data = null;

    public static function displayName(): string
    {
        return 'Answer';
    }

    public static function lowerDisplayName(): string
    {
        return 'answer';
    }

    public static function pluralDisplayName(): string
    {
        return 'Answers';
    }

    public static function pluralLowerDisplayName(): string
    {
        return 'answers';
    }

    public static function refHandle(): ?string
    {
        return 'answer';
    }

    public static function trackChanges(): bool
    {
        return true;
    }

    public static function hasContent(): bool
    {
        return false;
    }

    public static function hasTitles(): bool
    {
        return false;
    }

    public static function hasUris(): bool
    {
        return false;
    }

    public static function isLocalized(): bool
    {
        return false;
    }

    public static function hasStatuses(): bool
    {
        return false;
    }

    public static function gqlTypeNameByContext(mixed $context): string
    {
        return 'Answer';
    }

    public static function find(): AnswerQuery
    {
        return Craft::createObject(AnswerQuery::class, [static::class]);
    }

    public static function createCondition(): ElementConditionInterface
    {
        return Craft::createObject(AnswerCondition::class, [static::class]);
    }

    protected static function defineSources(string $context): array
    {
        return [
            [
                'key' => '*',
                'label' => 'All answers',
            ],
        ];
    }

    protected static function defineActions(string $source): array
    {
        // List any bulk element actions here
        return [];
    }

    protected static function includeSetStatusAction(): bool
    {
        return true;
    }

    protected static function defineSortOptions(): array
    {
        return [];
    }

    protected static function defineTableAttributes(): array
    {
        return [];
    }

    protected static function defineDefaultTableAttributes(string $source): array
    {
        return [];
    }

    protected function defineRules(): array
    {
        return array_merge(parent::defineRules(), [
            // ...
        ]);
    }

    public function getUriFormat(): ?string
    {
        // If answers should have URLs, define their URI format here
        return null;
    }

    protected function previewTargets(): array
    {
        $previewTargets = [];
        $url = $this->getUrl();
        if ($url) {
            $previewTargets[] = [
                'label' => Craft::t('app', 'Primary {type} page', [
                    'type' => self::lowerDisplayName(),
                ]),
                'url' => $url,
            ];
        }
        return $previewTargets;
    }

    protected function route(): array|string|null
    {
        // Define how answers should be routed when their URLs are requested
        return [
            'templates/render',
            [
                'template' => 'site/template/path',
                'variables' => ['answer' => $this],
            ]
        ];
    }

    public function canView(User $user): bool
    {
        if (parent::canView($user)) {
            return true;
        }
        // todo: implement user permissions
        return $user->can('viewAnswers');
    }

    public function canSave(User $user): bool
    {
        if (parent::canSave($user)) {
            return true;
        }
        // todo: implement user permissions
        return $user->can('saveAnswers');
    }

    public function canDuplicate(User $user): bool
    {
        if (parent::canDuplicate($user)) {
            return true;
        }
        // todo: implement user permissions
        return $user->can('saveAnswers');
    }

    public function canDelete(User $user): bool
    {
        if (parent::canSave($user)) {
            return true;
        }
        // todo: implement user permissions
        return $user->can('deleteAnswers');
    }

    public function canCreateDrafts(User $user): bool
    {
        return true;
    }

    protected function cpEditUrl(): ?string
    {
        return sprintf('answers/%s', $this->getCanonicalId());
    }

    public function getPostEditUrl(): ?string
    {
        return UrlHelper::cpUrl('answers');
    }

    public function prepareEditScreen(Response $response, string $containerId): void
    {
        /** @var Response|CpScreenResponseBehavior $response */
        $response->crumbs([
            [
                'label' => self::pluralDisplayName(),
                'url' => UrlHelper::cpUrl('answers'),
            ],
        ]);
    }

    public function afterSave(bool $isNew): void
    {
        if (!$this->propagating) {
            Db::upsert('investigation_answers', [
                'id' => $this->id,
                'questionId' => $this->questionId,
                'userId' => $this->userId,
                'investigationId' => $this->investigationId,
                'data' => $this->data
            ], [
                'data' => $this->data
            ]);
        }

        parent::afterSave($isNew);
    }
}
