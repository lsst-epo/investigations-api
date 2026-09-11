<?php

namespace modules\investigations\utilities;

use Craft;
use craft\base\Utility;
use craft\elements\User;
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
     * Reports a Google Cloud volume whose credentials are missing, which would
     * otherwise fail deep inside the upload with a bare DomainException.
     */
    private static function fsWarning($volume): ?string
    {
        if (!($volume->getFs() instanceof \craft\googlecloud\Fs)) {
            return null;
        }

        $credentials = getenv('GOOGLE_APPLICATION_CREDENTIALS') ?: '';

        if ($credentials === '') {
            return 'GOOGLE_APPLICATION_CREDENTIALS is not set, so this volume cannot be written to.';
        }

        if (!is_file($credentials)) {
            return "GOOGLE_APPLICATION_CREDENTIALS points at a file that does not exist ($credentials).";
        }

        return null;
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
