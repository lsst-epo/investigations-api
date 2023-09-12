<?php

namespace modules\investigations;

use Craft;
use craft\events\RegisterComponentTypesEvent;
use craft\events\RegisterGqlMutationsEvent;
use craft\events\RegisterGqlQueriesEvent;
use craft\events\RegisterGqlSchemaComponentsEvent;
use craft\events\RegisterGqlTypesEvent;
use craft\events\RegisterUrlRulesEvent;
use craft\services\Elements;
use craft\services\Gql;
use modules\investigations\gql\queries\Answer as AnswerGqlQuery;
use modules\investigations\gql\interfaces\elements\Answer as AnswerInterface;
use modules\investigations\gql\mutations\Answer as AnswerMutations;
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

        // Register GQL types, queries, mutations and schema components:
        Event::on(Gql::class, Gql::EVENT_REGISTER_GQL_TYPES, function(RegisterGqlTypesEvent $event) {
                $event->types[] = AnswerInterface::class;
            }
        );

        Event::on(Gql::class, Gql::EVENT_REGISTER_GQL_QUERIES, function(RegisterGqlQueriesEvent $event) {
                $event->queries = array_merge(
                    $event->queries,
                    AnswerGqlQuery::getQueries()
                );
            }
        );

        Event::on(Gql::class, Gql::EVENT_REGISTER_GQL_MUTATIONS, function(RegisterGqlMutationsEvent $event) {
                $event->mutations = array_merge(
                    $event->mutations, AnswerMutations::getMutations(),
                );
            }
        );

        Event::on(Gql::class, Gql::EVENT_REGISTER_GQL_SCHEMA_COMPONENTS, function(RegisterGqlSchemaComponentsEvent $event) {
            $event->queries = array_merge($event->queries, [
                'Answers' => [
                    'answers:read' => ['label' => 'View "Answer" elements']
                ]
            ]);

            $event->mutations = array_merge($event->mutations, [
                'Answers' => [
                    'answers:edit' => ['label' => 'Make edits to "Answer" elements'],
                    'answers:save' => ['label' => 'Save "Answer" elements']
                ]
            ]);
        });
    }
}
