<?php

namespace modules\investigations\controllers;

use Craft;
use craft\queue\Queue;
use craft\web\Controller;
use craft\web\UploadedFile;
use modules\investigations\jobs\ImportAssessments;
use modules\investigations\jobs\JobResults;
use modules\investigations\jobs\UploadAssessmentAssets;
use modules\investigations\Module;
use yii\web\Response;

/**
 * Backs the Assessments Import utility.
 */
class AssessmentsImportController extends Controller
{
    private const PERMISSION = 'utility:assessments-import';

    public function beforeAction($action): bool
    {
        if (!parent::beforeAction($action)) {
            return false;
        }

        $this->requirePostRequest();
        $this->requireAcceptsJson();
        $this->requirePermission(self::PERMISSION);

        return true;
    }

    /**
     * Unpacks an uploaded bundle zip into the import directory.
     */
    public function actionUploadBundle(): Response
    {
        $file = UploadedFile::getInstanceByName('bundle');

        if (!$file) {
            // An oversized POST arrives with no file and no error code.
            return $this->asFailure(Craft::t(
                'app',
                'No file was received. It may have exceeded the {size} upload limit.',
                ['size' => ini_get('post_max_size')]
            ));
        }

        if ($file->getHasError()) {
            return $this->asFailure($file->error === UPLOAD_ERR_INI_SIZE
                ? Craft::t('app', 'That file is larger than the {size} upload limit.', ['size' => ini_get('upload_max_filesize')])
                : Craft::t('app', 'The upload failed.'));
        }

        if (strtolower($file->getExtension()) !== 'zip') {
            return $this->asFailure(Craft::t('app', 'The bundle must be a .zip file.'));
        }

        $service = Module::getInstance()->assessmentsImport;

        try {
            $service->unpackBundle($file->tempName);
        } catch (\Throwable $e) {
            return $this->asFailure($e->getMessage());
        }

        $state = $service->bundleState();

        if ($state['records'] === 0) {
            return $this->asFailure(Craft::t(
                'app',
                'The bundle has no readable assessments.json. Check that the zip contains the bundle files at its top level.'
            ));
        }

        // The queue worker that runs the next steps may be on another pod.
        $warning = $service->publishBundle($file->tempName);

        return $this->asJson(['success' => true, 'state' => $state, 'warning' => $warning]);
    }

    public function actionUploadAssets(): Response
    {
        $request = Craft::$app->getRequest();
        $resultKey = JobResults::key();

        $jobId = Craft::$app->getQueue()->push(new UploadAssessmentAssets([
            'volumeHandle' => $request->getBodyParam('volume') ?: null,
            'dryRun' => (bool)$request->getBodyParam('dryRun'),
            'resultKey' => $resultKey,
        ]));

        return $this->asJson(['success' => true, 'jobId' => $jobId, 'resultKey' => $resultKey]);
    }

    public function actionImport(): Response
    {
        $request = Craft::$app->getRequest();
        $resultKey = JobResults::key();
        $dryRun = (bool)$request->getBodyParam('dryRun');

        $jobId = Craft::$app->getQueue()->push(new ImportAssessments([
            'dryRun' => $dryRun,
            'allowMissingAssets' => (bool)$request->getBodyParam('allowMissingAssets'),
            'author' => $request->getBodyParam('author') ?: null,
            'cleanup' => !$dryRun && (bool)$request->getBodyParam('cleanup'),
            'resultKey' => $resultKey,
        ]));

        return $this->asJson(['success' => true, 'jobId' => $jobId, 'resultKey' => $resultKey]);
    }

    /**
     * Reports a job's progress, and its result once it has finished.
     */
    public function actionStatus(): Response
    {
        $request = Craft::$app->getRequest();
        $jobId = $request->getRequiredBodyParam('jobId');
        $resultKey = $request->getRequiredBodyParam('resultKey');

        $result = JobResults::fetch($resultKey);

        if ($result !== null) {
            // The job may have run on another pod.
            $service = Module::getInstance()->assessmentsImport;
            $service->syncBundle();

            return $this->asJson([
                'success' => true,
                'status' => 'done',
                'result' => $result,
                'state' => $service->bundleState(),
            ]);
        }

        $info = null;
        foreach (Craft::$app->getQueue()->getJobInfo() as $job) {
            if ((string)$job['id'] === (string)$jobId) {
                $info = $job;
                break;
            }
        }

        if ($info === null) {
            // Gone from the queue with nothing cached: the worker died mid-job.
            return $this->asJson([
                'success' => true,
                'status' => 'lost',
                'message' => Craft::t('app', 'The job is no longer in the queue and left no result. Check the queue for a failed job.'),
            ]);
        }

        return $this->asJson([
            'success' => true,
            'status' => (int)$info['status'] === Queue::STATUS_FAILED ? 'failed' : 'running',
            'progress' => $info['progress'] ?? 0,
            'progressLabel' => $info['progressLabel'] ?? null,
            'error' => $info['error'] ?? null,
        ]);
    }
}
