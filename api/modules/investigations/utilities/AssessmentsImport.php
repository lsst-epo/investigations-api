<?php

namespace modules\investigations\utilities;

use Craft;
use craft\base\Utility;
use craft\elements\User;
use craft\helpers\App;
use Google\Auth\CredentialsLoader;
use modules\investigations\assetbundles\assessmentsimport\AssessmentsImportAsset;
use modules\investigations\Module;

/**
 * Guides an operator through uploading and importing an assessments bundle.
 */
class AssessmentsImport extends Utility
{
    public static function displayName(): string
    {
        return Craft::t('app', 'Assessments Import');
    }

    public static function id(): string
    {
        return 'assessments-import';
    }

    public static function iconPath(): ?string
    {
        return Craft::getAlias('@appicons/wand.svg');
    }

    public static function contentHtml(): string
    {
        $view = Craft::$app->getView();
        $view->registerAssetBundle(AssessmentsImportAsset::class);
        $view->registerJs('new InvestigationsAssessmentsImport();');

        $service = Module::getInstance()->assessmentsImport;

        // Another pod may have uploaded the bundle or run a step.
        $service->syncBundle();

        return $view->renderTemplate('investigations/utilities/assessments-import.twig', [
            'state' => $service->bundleState(),
            'volumes' => static::volumeOptions(),
            'maxUploadSize' => static::maxUploadBytes(),
            'currentUser' => Craft::$app->getUser()->getIdentity(),
        ]);
    }

    /**
     * Volume options, each carrying a description of its filesystem and any
     * problem that would stop an upload.
     */
    private static function volumeOptions(): array
    {
        $service = Module::getInstance()->assessmentsImport;
        $options = [];

        foreach (Craft::$app->getVolumes()->getAllVolumes() as $volume) {
            $options[] = [
                'value' => $volume->handle,
                'label' => $volume->name,
                'fs' => $service->describeFs($volume),
                'warning' => static::fsWarning($volume),
            ];
        }

        return $options;
    }

    /**
     * Reports a Google Cloud volume with no local credentials, which would
     * otherwise fail deep inside the upload with a bare DomainException.
     *
     * Checks only the sources that need no network call: the filesystem's key,
     * GOOGLE_APPLICATION_CREDENTIALS and gcloud's application default
     * credentials file. The GCP metadata server can still supply credentials
     * when none of these exist.
     */
    private static function fsWarning($volume): ?string
    {
        $fs = $volume->getFs();

        if (!($fs instanceof \craft\googlecloud\Fs)) {
            return null;
        }

        if (!empty(App::parseEnv($fs->keyFileContents))) {
            return null;
        }

        $credentials = getenv(CredentialsLoader::ENV_VAR) ?: '';

        if ($credentials !== '') {
            return is_file($credentials)
                ? null
                : "GOOGLE_APPLICATION_CREDENTIALS points at a file that does not exist ($credentials).";
        }

        if (CredentialsLoader::fromWellKnownFile() !== null) {
            return null;
        }

        return 'No local Google Cloud credentials found, so uploads to this volume will only work on GCP-hosted infrastructure.';
    }

    private static function maxUploadBytes(): int
    {
        $toBytes = static function(string $value): int {
            $value = trim($value);
            $unit = strtolower(substr($value, -1));
            $number = (int)$value;

            return match ($unit) {
                'g' => $number * 1024 * 1024 * 1024,
                'm' => $number * 1024 * 1024,
                'k' => $number * 1024,
                default => $number,
            };
        };

        return min(
            $toBytes(ini_get('upload_max_filesize') ?: '0'),
            $toBytes(ini_get('post_max_size') ?: '0')
        );
    }
}
