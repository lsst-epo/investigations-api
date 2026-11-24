<?php
/**
 * User Registration module for Craft CMS 3.x
 *
 * Customized FE user registration flow.
 *
 * @link      https://castironcoding.com/
 * @copyright Copyright (c) 2022 Cast Iron Coding
 */

namespace modules\userregistrationmodule;

use craft\controllers\GraphqlController;
use craft\base\Element;
use craft\elements\User;
use craft\errors\InvalidFieldException;
use craft\events\ModelEvent;
use craft\events\RegisterEmailMessagesEvent;
use craft\events\UserEvent;
use craft\helpers\Queue;
use craft\mail\Mailer;
use craft\mail\Message;
use craft\models\SystemMessage;
use craft\services\SystemMessages;
use craft\services\Users;
use modules\userregistrationmodule\assetbundles\userregistrationmodule\UserRegistrationModuleAsset;
use modules\userregistrationmodule\jobs\SendSystemEmail;

use Craft;
use craft\events\RegisterTemplateRootsEvent;
use craft\events\TemplateEvent;
use craft\i18n\PhpMessageSource;
use craft\web\View;

use yii\base\Event;
use yii\base\InvalidConfigException;
use yii\base\Module;
use yii\mail\BaseMailer;
use yii\mail\MailEvent;

/**
 * Craft plugins are very much like little applications in and of themselves. We’ve made
 * it as simple as we can, but the training wheels are off. A little prior knowledge is
 * going to be required to write a plugin.
 *
 * For the purposes of the plugin docs, we’re going to assume that you know PHP and SQL,
 * as well as some semi-advanced concepts like object-oriented programming and PHP namespaces.
 *
 * https://craftcms.com/docs/plugins/introduction
 *
 * @author    Cast Iron Coding
 * @package   UserRegistrationModule
 * @since     1.0.0

 */
class UserRegistrationModule extends Module
{
    // Static Properties
    // =========================================================================

    /**
     * Static property that is an instance of this module class so that it can be accessed via
     * UserRegistrationModule::$instance
     *
     * @var UserRegistrationModule
     */
    public static $instance;

    /** Object IDs of users whose save is switching on educator approval. */
    private array $approvingUsers = [];

    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function __construct($id, $parent = null, array $config = [])
    {
        Craft::setAlias('@modules/userregistrationmodule', $this->getBasePath());
        $this->controllerNamespace = 'modules\userregistrationmodule\controllers';

        // Translation category
        $i18n = Craft::$app->getI18n();
        /** @noinspection UnSafeIsSetOverArrayInspection */
        if (!isset($i18n->translations[$id]) && !isset($i18n->translations[$id.'*'])) {
            $i18n->translations[$id] = [
                'class' => PhpMessageSource::class,
                'sourceLanguage' => 'en-US',
                'basePath' => '@modules/userregistrationmodule/translations',
                'forceTranslation' => true,
                'allowOverrides' => true,
            ];
        }

        // Base template directory
        Event::on(View::class, View::EVENT_REGISTER_CP_TEMPLATE_ROOTS, function (RegisterTemplateRootsEvent $e) {
            if (is_dir($baseDir = $this->getBasePath().DIRECTORY_SEPARATOR.'templates')) {
                $e->roots[$this->id] = $baseDir;
            }
        });

        // Set this as the global instance of this module class
        static::setInstance($this);

        parent::__construct($id, $parent, $config);
    }

    /**
     * Set our $instance static property to this class so that it can be accessed via
     * UserRegistrationModule::$instance
     *
     * Called after the module class is instantiated; do any one-time initialization
     * here such as hooks and events.
     *
     * If you have a '/vendor/autoload.php' file, it will be loaded for you automatically;
     * you do not need to load it in your init() method.
     *
     */
    public function init()
    {
        parent::init();
        self::$instance = $this;

        // Load our AssetBundle
        if (Craft::$app->getRequest()->getIsCpRequest()) {
            Event::on(
                View::class,
                View::EVENT_BEFORE_RENDER_TEMPLATE,
                function (TemplateEvent $event) {
                    try {
                        Craft::$app->getView()->registerAssetBundle(UserRegistrationModuleAsset::class);
                    } catch (InvalidConfigException $e) {
                        Craft::error(
                            'Error registering AssetBundle - '.$e->getMessage(),
                            __METHOD__
                        );
                    }
                }
            );
        }

		Event::on(
			SystemMessages::class,
			SystemMessages::EVENT_REGISTER_MESSAGES,
			function (RegisterEmailMessagesEvent $event) {
				array_push($event->messages, ...$this->educatorMessages());
			}
		);

		// Defer GraphQL activation emails to a retryable queue job
		Event::on(
			Mailer::class,
			BaseMailer::EVENT_BEFORE_SEND,
			function (MailEvent $event) {
				$this->queueActivationEmail($event);
			}
		);

		Event::on(
			Users::class,
			Users::EVENT_BEFORE_ACTIVATE_USER,
			function (UserEvent $event) {
				if (
					$this->isEducator($event->user) &&
					!Craft::$app->getRequest()->getIsConsoleRequest() &&
					!$this->isApproved($event->user)
				) {
					$event->isValid = false;
				}
			}
		);

		Event::on(
			User::class,
			Element::EVENT_BEFORE_SAVE,
			function (ModelEvent $event) {
				$this->guardApproval($event->sender);
			}
		);

		Event::on(
			User::class,
			Element::EVENT_AFTER_SAVE,
			function (ModelEvent $event) {
				$this->sendApproval($event->sender);
			}
		);

/**
 * Logging in Craft involves using one of the following methods:
 *
 * Craft::trace(): record a message to trace how a piece of code runs. This is mainly for development use.
 * Craft::info(): record a message that conveys some useful information.
 * Craft::warning(): record a warning message that indicates something unexpected has happened.
 * Craft::error(): record a fatal error that should be investigated as soon as possible.
 *
 * Unless `devMode` is on, only Craft::warning() & Craft::error() will log to `craft/storage/logs/web.log`
 *
 * It's recommended that you pass in the magic constant `__METHOD__` as the second parameter, which sets
 * the category to the method (prefixed with the fully qualified class name) where the constant appears.
 *
 * To enable the Yii debug toolbar, go to your user account in the AdminCP and check the
 * [] Show the debug toolbar on the front end & [] Show the debug toolbar on the Control Panel
 *
 * http://www.yiiframework.com/doc-2.0/guide-runtime-logging.html
 */
        Craft::info(
            Craft::t(
                'user-registration-module',
                '{name} module loaded',
                ['name' => 'User Registration']
            ),
            __METHOD__
        );
    }

    // Protected Methods
    // =========================================================================

	/**
	 * Replaces a GraphQL request's activation email send with a queued job.
	 * Educators get a pending-review email instead of an activation link.
	 *
	 * @param MailEvent $event
	 */
	protected function queueActivationEmail(MailEvent $event): void
	{
		$message = $event->message;

		if (
			!$message instanceof Message ||
			$message->key !== 'account_activation' ||
			!Craft::$app->controller instanceof GraphqlController
		) {
			return;
		}

		$user = $message->variables['user'] ?? null;
		$link = $message->variables['link'] ?? null;

		if (!$user instanceof User || !$user->id || $link === null) {
			return;
		}

		if ($this->isEducator($user)) {
			$job = new SendSystemEmail([
				'key' => 'educator_pending',
				'userId' => $user->id,
				'language' => $message->language,
				'requirePending' => true,
			]);
		} else {
			$job = new SendSystemEmail([
				'key' => 'account_activation',
				'userId' => $user->id,
				'variables' => ['link' => (string)$link],
				'language' => $message->language,
				'requirePending' => true,
			]);
		}

		Queue::push($job);
		$event->isValid = false;
	}

	/**
	 * Reverts changes to the approval field unless made from the console or by
	 * a user with the administrateUsers permission, and records approvals.
	 *
	 * @param User $user
	 */
	protected function guardApproval(User $user): void
	{
		if (!$this->hasApprovalField($user) || !$user->isFieldDirty('educatorApproved')) {
			return;
		}

		if (!$this->canApprove()) {
			$original = $user->id ? Craft::$app->getUsers()->getUserById($user->id) : null;
			$user->setFieldValue('educatorApproved', $original ? $this->isApproved($original) : false);
			return;
		}

		if ($this->isApproved($user)) {
			$this->approvingUsers[spl_object_id($user)] = true;
		}
	}

	/**
	 * Emails a newly approved, still pending educator their activation link.
	 *
	 * @param User $user
	 */
	protected function sendApproval(User $user): void
	{
		$key = spl_object_id($user);

		if (!isset($this->approvingUsers[$key])) {
			return;
		}

		unset($this->approvingUsers[$key]);

		if (!$user->pending || !$this->isEducator($user)) {
			return;
		}

		Queue::push(new SendSystemEmail([
			'key' => 'educator_approved',
			'userId' => $user->id,
			'variables' => ['link' => Craft::$app->getUsers()->getActivationUrl($user)],
			'requirePending' => true,
		]));
	}

	/**
	 * Whether the current actor may change educator approval.
	 *
	 * @return bool
	 */
	protected function canApprove(): bool
	{
		if (Craft::$app->getRequest()->getIsConsoleRequest()) {
			return true;
		}

		$actor = Craft::$app->getUser()->getIdentity();

		return $actor !== null && $actor->can('administrateUsers');
	}

	/**
	 * @param User $user
	 * @return bool
	 */
	protected function hasApprovalField(User $user): bool
	{
		return $user->getFieldLayout()?->getFieldByHandle('educatorApproved') !== null;
	}

	/**
	 * @param User $user
	 * @return bool
	 */
	protected function isApproved(User $user): bool
	{
		try {
			return (bool)$user->getFieldValue('educatorApproved');
		} catch (InvalidFieldException) {
			return false;
		}
	}

	/**
	 * @param User $user
	 * @return bool
	 */
	protected function isEducator(User $user): bool
	{
		return $this->hasEducatorsGroup(Craft::$app->getUserGroups()->getGroupsByUserId($user->id));
	}

	/**
	 * @param array $groups
	 * @return bool
	 */
	protected function hasEducatorsGroup(array $groups)
	{
		foreach($groups as $group) {
			if($group->handle == 'educators') return true;
		}
		return false;
	}

	/**
	 * System messages for the educator approval workflow.
	 *
	 * @return SystemMessage[]
	 */
	protected function educatorMessages(): array
	{
		return [
			new SystemMessage([
				'key' => 'educator_pending',
				'heading' => 'When an educator registers and is awaiting approval:',
				'subject' => 'Your Educator registration is pending review',
				'body' => "Hey {{user.friendlyName|e}},\n\n" .
					"Thank you for registering as an Educator.\n\n" .
					"Your account is pending review. You will be notified again when we've activated your account.",
			]),
			new SystemMessage([
				'key' => 'educator_approved',
				'heading' => 'When an admin approves an educator registration:',
				'subject' => 'Your Educator registration has been approved',
				'body' => "Hey {{user.friendlyName|e}},\n\n" .
					"Thanks for your patience! Your Educator registration has been approved. " .
					"To activate your account, click the following link:\n\n" .
					"{{link}}\n\n" .
					"If you were not expecting this email, just ignore it.",
			]),
		];
	}
}
