Feature: Betting
    In order to earn money playing Blackjack
    As a user
    I want to be able to bet money before each game

    Scenario: Win chips
        Given I am a user with 500 dollars
        When I bet 100 dollars before a game
        And I win the game
        Then I should have 600 dollars
