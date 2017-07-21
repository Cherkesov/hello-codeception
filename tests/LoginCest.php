<?php

class LoginCest
{
    public function _before(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $I->click('Log In');
        $I->canSeeInCurrentUrl('/users/login');
    }

    public function loginSuccessfully(AcceptanceTester $I)
    {
        $I->wantTo('Ensure that login work fine for correct credentials');
        $I->randSleep();

        $user = $I->getRandUserByRoles(['STACKOVERFLOW_USER']);

        $I->fillField('#email', $user->getUsername());
        $I->fillField('#password', $user->getPassword());
        $I->click('#submit-button');

        $I->amOnPage('/');

        $I->seeElement('.my-profile');
        $I->seeElement('.secondary-nav');
        $I->seeNumberOfElements('.question-summary', 96);
    }

    public function loginWithInvalidPassword(AcceptanceTester $I)
    {
        $I->wantTo('Ensure that login work fine for incorrect credentials');
        $I->randSleep();

        $I->fillField('#email', 'hello-wildfowl@gmail.com');
        $I->fillField('#password', 'hello-wildfowl-123456');
        $I->click('#submit-button');

        $I->waitForText('The email or password is incorrect.');
    }
}