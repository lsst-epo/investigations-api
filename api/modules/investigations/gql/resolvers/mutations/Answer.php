<?php

namespace modules\investigations\gql\resolvers\mutations;

use craft\gql\base\ElementMutationResolver;
use GraphQL\Error\UserError;
use GraphQL\Type\Definition\ResolveInfo;
use modules\investigations\elements\Answer as AnswerElement;

class Answer extends ElementMutationResolver
{
    protected array $immutableAttributes = ['id', 'uid'];

    public function saveAnswer($source, array $arguments, $context, ResolveInfo $resolveInfo)
    {
        $elementService = \Craft::$app->getElements();

        if(array_key_exists('id', $arguments) && $elementService->getElementById($arguments['id'])) {
            $answer = $elementService->getElementById($arguments['id']);
        } else {
            $answer = $elementService->createElement(AnswerElement::class);
        }

        $answer = $this->populateElementWithData($answer, $arguments);
        $answer = $this->saveElement($answer);

        if($answer->hasErrors()) {
            $validationErrors = [];

            foreach ($answer->getFirstErrors() as $attribute => $errorMessage) {
                $validationErrors[] = $errorMessage;
            }

            throw new UserError(implode("\n", $validationErrors));
        }

        return $elementService->getElementById($answer->id, AnswerElement::class);
    }
}
