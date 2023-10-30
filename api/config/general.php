<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */

use craft\helpers\App;

$gcsBucketPathFormat = 'https://storage.googleapis.com/%s/';

return [
    // Global settings
    '*' => [
        // Disable automatic running of queue jobs upon page loads in CP, which causes queue jobs to fail
        // Supervisord now handles running queue jobs
        'runQueueAutomatically' => false,
        // Default Week Start Day (0 = Sunday, 1 = Monday...)
        'defaultWeekStartDay' => 1,

        // Whether generated URLs should omit "index.php"
        'omitScriptNameInUrls' => true,

        // Control Panel trigger word
        'cpTrigger' => 'admin',

        // The secure key Craft will use for hashing and encrypting data
        'securityKey' => App::env('SECURITY_KEY'),

        'aliases' => [
            '@webroot' => dirname(__DIR__) . '/web',
            '@webBaseUrl' => App::env('WEB_BASE_URL'),
            '@previewUrlFormat' => App::env('ALIAS_PREVIEW_URL_FORMAT'),
            '@assetsGeneralBaseURL' => sprintf(
                $gcsBucketPathFormat,
                App::env('GCS_GENERAL_BUCKET')
            ),
        ],

        'headlessMode' => true,

        // FE user account management paths. Must be absolute URLs
        'verifyEmailPath' => App::env('VERIFY_EMAIL_PATH'),
        'setPasswordPath' => App::env('SET_PASSWORD_PATH'),

        // Configured in apache conf. It's not easy to get Craft
        // to serve CORS headers for both GraphQL and non-Graphql 
        // requests (eg, the contact form), so we went with this 
        // approach.
        'allowedGraphqlOrigins' => false,
        'enableGraphqlCaching' => false,
    ],

    // Dev environment settings
    'dev' => [
        // Dev Mode (see https://craftcms.com/guides/what-dev-mode-does)
        'devMode' => true,
    ],

    // Staging environment settings
    'staging' => [
        // Set this to `false` to prevent administrative changes from being made on staging
        'allowAdminChanges' => false,
    ],

    // Production environment settings
    'production' => [
        // Set this to `false` to prevent administrative changes from being made on production
        'allowAdminChanges' => false,
    ],
];
