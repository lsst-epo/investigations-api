<?php
/**
 * User Registration module for Craft CMS 3.x
 *
 * Customized FE user registration flow.
 *
 * @link      https://castironcoding.com/
 * @copyright Copyright (c) 2022 Cast Iron Coding
 */

namespace modules\userregistrationmodule\services;

use craft\elements\User;
use Craft;
use craft\base\Component;

/**
 * NotificationService Service
 *
 * All of your module’s business logic should go in services, including saving data,
 * retrieving data, etc. They provide APIs that your controllers, template variables,
 * and other modules can interact with.
 *
 * https://craftcms.com/docs/plugins/services
 *
 * @author    Cast Iron Coding
 * @package   UserRegistrationModule
 * @since     1.0.0
 */
class NotificationService extends Component
{
    // Public Methods
    // =========================================================================

	/**
	 * @param User $user
	 * @return bool
	 */
	public function sendEducatorSuspendNotification(User $user)
	{
		$template = file_get_contents(__DIR__.'/../templates/email/educator-suspend.html');
		return Craft::$app->mailer->compose()
			->setTo($user->email)
			->setSubject('Your registration as an Educator is pending')
			->setHtmlBody($template)
			->send();
	}

	/**
	 * @param User $user
	 * @return bool
	 */
	public function sendEducatorUnsuspendNotification(User $user)
	{
		$template = file_get_contents(__DIR__.'/../templates/email/educator-unsuspend.html');
		return Craft::$app->mailer->compose()
			->setTo($user->email)
			->setSubject('Your Educator account is now active')
			->setHtmlBody($template)
			->send();
	}
}
