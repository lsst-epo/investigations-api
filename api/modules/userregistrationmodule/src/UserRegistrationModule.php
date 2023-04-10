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

use craft\events\UserEvent;
use craft\services\Users;
use modules\userregistrationmodule\assetbundles\userregistrationmodule\UserRegistrationModuleAsset;
use modules\userregistrationmodule\services\NotificationService;
use modules\userregistrationmodule\services\NotificationService as NotificationServiceService;

use Craft;
use craft\events\RegisterTemplateRootsEvent;
use craft\events\TemplateEvent;
use craft\i18n\PhpMessageSource;
use craft\web\View;

use yii\base\Event;
use yii\base\InvalidConfigException;
use yii\base\Module;

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
 *
 * @property  NotificationServiceService $notificationService
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

		// Send special notifications during some User events
		Event::on(
			Users::class,
			Users::EVENT_AFTER_ACTIVATE_USER,
			function (UserEvent $event) {
				$user = $event->user;
				$groups = Craft::$app->userGroups->getGroupsByUserId($user->getId());

				if($this->hasEducatorsGroup($groups)) {
					$event->isValid = false;

					$usersService = Craft::$app->getUsers();
					$usersService->suspendUser($user);

					$notificationService = new NotificationService();
					$notificationService->sendEducatorSuspendNotification($user);
				}
			}
		);

		Event::on(
			Users::class,
			Users::EVENT_AFTER_UNSUSPEND_USER,
			function (UserEvent $event) {
				$user = $event->user;
				$groups = Craft::$app->userGroups->getGroupsByUserId($user->id);

				if($this->hasEducatorsGroup($groups)) {
					$notificationService = new NotificationService();
					$notificationService->sendEducatorUnsuspendNotification($user);
				}
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
}
