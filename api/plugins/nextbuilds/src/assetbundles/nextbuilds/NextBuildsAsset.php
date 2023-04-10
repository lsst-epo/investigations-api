<?php
/**
 * Next Builds plugin for Craft CMS 3.x
 *
 * Start Next.js page builds from Craft.
 *
 * @link      https://castironcoding.com/
 * @copyright Copyright (c) 2022 Cast Iron Coding
 */

namespace castiron\nextbuilds\assetbundles\nextbuilds;

use Craft;
use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

/**
 * @author    Cast Iron Coding
 * @package   NextBuilds
 * @since     1.0.0
 */
class NextBuildsAsset extends AssetBundle
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function init()
    {
        $this->sourcePath = "@castiron/nextbuilds/assetbundles/nextbuilds/dist";

        $this->depends = [
            CpAsset::class,
        ];

        $this->js = [
            'js/NextBuilds.js',
        ];

        $this->css = [
            'css/NextBuilds.css',
        ];

        parent::init();
    }
}
