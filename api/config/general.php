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

$dev = App::env('ENVIRONMENT') === 'dev';

$s3BucketPathFormat = 'https://s3.%s.amazonaws.com/%s/';
$gcsBucketPathFormat = 'https://storage.googleapis.com/%s/';

return [
    // Global settings
    '*' => [
        // Default Week Start Day (0 = Sunday, 1 = Monday...)
        'defaultWeekStartDay' => 1,

        // Whether generated URLs should omit "index.php"
        'omitScriptNameInUrls' => true,

        // Control Panel trigger word
        'cpTrigger' => 'admin',

        // The secure key Craft will use for hashing and encrypting data
        'securityKey' => App::env('SECURITY_KEY'),

        // Whether to save the project config out to config/project.yaml
        // (see https://docs.craftcms.com/v3/project-config.html)
        'useProjectConfigFile' => true,

        'aliases' => [
            '@previewUrlFormat' => App::env('ALIAS_PREVIEW_URL_FORMAT'),
            '@assetsAssetVariantBaseURL' => sprintf(
                $s3BucketPathFormat,
                App::env('AWS_ASSET_S3_REGION'),
                App::env('AWS_ASSET_S3_BUCKET')
            ),
            '@assetsGeneralBaseURL' => sprintf(
                $gcsBucketPathFormat,
                App::env('GCS_GENERAL_BUCKET')
            ),
            '@assetsHeroesBaseURL' => sprintf(
                $gcsBucketPathFormat,
                App::env('GCS_HEROES_BUCKET')
            ),
            '@assetsContentBaseURL' => sprintf(
                $gcsBucketPathFormat,
                App::env('GCS_CONTENT_BUCKET')
            ),
            '@assetsCalloutsBaseURL' => sprintf(
                $gcsBucketPathFormat,
                App::env('GCS_CALLOUTS_BUCKET')
            ),
            '@assetsStaffBaseURL' => sprintf(
                $gcsBucketPathFormat,
                App::env('GCS_STAFF_BUCKET')
            ),
            '@webBaseUrl' => App::env('WEB_BASE_URL')
        ],

        'allowedGraphqlOrigins' => false,

        'headlessMode' => true //,

        // Disable CSRF protection for contact form - unnecessary until we implement certs
        //'enableCsrfProtection' => $_SERVER['REQUEST_URI'] !== '/actions/contact-form/send',


    ],

    // Dev environment settings
    'dev' => [
        // Dev Mode (see https://craftcms.com/guides/what-dev-mode-does)
        'devMode' => App::env('ENVIRONMENT') === 'dev',
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
