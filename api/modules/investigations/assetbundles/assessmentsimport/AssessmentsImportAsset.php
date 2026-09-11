<?php

namespace modules\investigations\assetbundles\assessmentsimport;

use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

/**
 * Front-end assets for the Assessments Import utility.
 */
class AssessmentsImportAsset extends AssetBundle
{
    public function init(): void
    {
        $this->sourcePath = __DIR__ . '/dist';

        $this->depends = [
            CpAsset::class,
        ];

        $this->js = [
            'assessments-import.js',
        ];

        $this->css = [
            'assessments-import.css',
        ];

        parent::init();
    }
}
