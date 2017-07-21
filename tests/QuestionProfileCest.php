<?php

class QuestionProfileCest
{
    public function check(AcceptanceTester $I)
    {
        $I->amOnPage('/');

        $res = $I->getElementsBy('.question-summary');
        $links = $I->getElementsBy('.question-hyperlink', $res[0]);
        $firstPostLink = $links[0];

        $I->randSleep(1, 5);

        $title = $firstPostLink->getText();
        $url = $firstPostLink->getAttribute('href');
        $uri = $I->getUriFrom($url);

        $firstPostLink->click();

        $I->seeCurrentUrlEquals($uri);
        $I->see($title, 'h1');
    }
}