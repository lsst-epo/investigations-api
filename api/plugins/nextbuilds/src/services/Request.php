<?php
/**
 * Next Builds plugin for Craft CMS 3.x
 *
 * Start Next.js page builds from Craft.
 *
 * @link      https://castironcoding.com/
 * @copyright Copyright (c) 2022 Cast Iron Coding
 */

namespace castiron\nextbuilds\services;

use Craft;
use castiron\nextbuilds\NextBuilds;
use craft\base\Component;
use craft\elements\Entry;
use craft\helpers\Session;
use GuzzleHttp\Client;

/**
 * @author    Cast Iron Coding
 * @package   NextBuilds
 * @since     1.0.0
 */
class Request extends Component
{
	const NEXT_ENDPOINT_REVALIDATE = '/revalidate';

    // Public Methods
    // =========================================================================

	/**
	 * @param Entry $entry
	 * @return void
	 * @throws \GuzzleHttp\Exception\GuzzleException
	 */
	public function buildPagesFromEntry(Entry $entry)
	{
		$settings = NextBuilds::getInstance()->getSettings();
		$client = new Client();

		$endpoint = $this->getSettingsData($settings->nextApiBaseUrl) . self::NEXT_ENDPOINT_REVALIDATE;
		$params = [
			'uri' => $entry->uri,
			'secret' => $this->getSettingsData($settings->nextSecretToken)
		];
		$requestUrl = $endpoint . '?' . http_build_query($params);

		try {
			$client->request('GET', $requestUrl, []);
		} catch (\Exception $exception) {
			$isConsoleRequest = Craft::$app->getRequest()->getIsConsoleRequest();
			if (!$isConsoleRequest) {
				Craft::$app->session->setError('Incremental rebuild failed. Frontend will update after next revalidation interval.');
			}
		}
	}

	// Protected Methods
	// =========================================================================

	/**
	 * @param string $setting
	 * @return string
	 */
	protected function getSettingsData(string $setting): string
	{
		if ($value = Craft::parseEnv($setting)) {
			return $value;
		}

		return $setting;
	}
}
