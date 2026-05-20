<?php

use craft\helpers\App;

return [
    'components' => [
        'session' => function() {
            // Get the default component config:
            $config = craft\helpers\App::sessionConfig();

            // Replace component class:
            $config['class'] = yii\redis\Session::class;

            // no need to define additional properties, pull the `redis` config from `app.php`
            $config['redis'] = 'redis';

            return Craft::createObject($config);
        }
    ],
];

?>