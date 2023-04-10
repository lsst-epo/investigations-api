<?php
/**
 * Next Builds plugin for Craft CMS 3.x
 *
 * Start Next.js page builds from Craft.
 *
 * @link      https://castironcoding.com/
 * @copyright Copyright (c) 2022 Cast Iron Coding
 */

namespace castiron\nextbuilds;

use castiron\nextbuilds\services\Request as RequestService;
use castiron\nextbuilds\models\Settings;

use Craft;
use craft\base\Plugin;
use craft\elements\Entry;
use craft\events\ModelEvent;
use craft\helpers\ElementHelper;
use craft\services\Plugins;
use craft\events\PluginEvent;
use castiron\nextbuilds\services\Request as NextRequestService;

use yii\base\Event;

/**
 * Class NextBuilds
 *
 * @author    Cast Iron Coding
 * @package   NextBuilds
 * @since     1.0.0
 *
 * @property  RequestService $request
 */
class NextBuilds extends Plugin
{
    // Static Properties
    // =========================================================================

    /**
     * @var NextBuilds
     */
    public static $plugin;

	/**
	 * @var Settings
	 */
	public static $settings;

    // Public Properties
    // =========================================================================

    /**
     * @var string
     */
    public string $schemaVersion = '1.0.0';

    /**
     * @var bool
     */
    public bool $hasCpSettings = true;

    /**
     * @var bool
     */
    public bool $hasCpSection = false;

    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function init()
    {
        parent::init();
        self::$plugin = $this;

        Event::on(
            Plugins::class,
            Plugins::EVENT_AFTER_INSTALL_PLUGIN,
            function (PluginEvent $event) {
                if ($event->plugin === $this) {
                }
            }
        );

	    $this->setComponents([
		    'request' => NextRequestService::class
	    ]);

        Craft::info(
            Craft::t(
                'next-builds',
                '{name} plugin loaded',
                ['name' => $this->name]
            ),
            __METHOD__
        );

	    // Event Listeners
	    Event::on(
		    Entry::class,
		    Entry::EVENT_AFTER_SAVE,
		    function (ModelEvent $event) {
			    $entry = $event->sender;
			    if (
				    $this->settings->activeSections[$entry->section->handle] &&
				    !ElementHelper::isDraft($entry) &&
				    !($entry->duplicateOf && $entry->getIsCanonical() && !$entry->updatingFromDerivative) &&
				    ($entry->enabled && $entry->getEnabledForSite()) &&
				    !ElementHelper::rootElement($entry)->isProvisionalDraft &&
				    !$entry->resaving &&
				    !ElementHelper::isRevision($entry)
			    ) {
				    $this->request->buildPagesFromEntry($entry);
			    }
		    }
	    );
    }

    // Protected Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    protected function createSettingsModel(): ?\craft\base\Model
    {
        return new Settings();
    }

    /**
     * @inheritdoc
     */
    protected function settingsHtml(): string
    {
        return Craft::$app->view->renderTemplate(
            'next-builds/settings',
            [
                'settings' => $this->getSettings()
            ]
        );
    }
}
