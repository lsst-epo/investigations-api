<?php

namespace modules\investigations;

use Craft;
use craft\events\RegisterComponentTypesEvent;
use craft\events\RegisterUrlRulesEvent;
use craft\services\Elements;
use craft\web\UrlManager;
use modules\investigations\elements\Answer;
use yii\base\Event;
use yii\base\Module as BaseModule;

/**
 * investigations module
 *
 * @method static Module getInstance()
 */
class Module extends BaseModule
{
    public function init()
    {
        Craft::setAlias('@modules/investigations', __DIR__);

        // Set the controllerNamespace based on whether this is a console or web request
        if (Craft::$app->request->isConsoleRequest) {
            $this->controllerNamespace = 'modules\\investigations\\console\\controllers';
        } else {
            $this->controllerNamespace = 'modules\\investigations\\controllers';
        }

        parent::init();

        // Defer most setup tasks until Craft is fully initialized
        Craft::$app->onInit(function() {
            $this->attachEventHandlers();
            // ...
        });
    }

    private function attachEventHandlers(): void
    {
        // Register event handlers here ...
        // (see https://craftcms.com/docs/4.x/extend/events.html to get started)
        Event::on(Elements::class, Elements::EVENT_REGISTER_ELEMENT_TYPES, function (RegisterComponentTypesEvent $event) {
            $event->types[] = Answer::class;
        });
        Event::on(UrlManager::class, UrlManager::EVENT_REGISTER_CP_URL_RULES, function (RegisterUrlRulesEvent $event) {
            $event->rules['answers'] = ['template' => 'investigations/answers/_index.twig'];
            $event->rules['answers/<elementId:\\d+>'] = 'elements/edit';
        });
    }
}
