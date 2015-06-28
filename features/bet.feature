Feature: Betting
    In order to earn money playing Blackjack
    As a user
    I want to be able to bet money before each game

    Scenario: Win money
        Given I am a user with 200 dollars
        When I bet 10 dollars before a game
        And I win the game
        Then I should have 210 dollars

    Scenario: Lose money
        Given I am a user with 200 dollars
        When I bet 10 dollars before a game
        And I lose the game
        Then I should have 190 dollars
        
    Scenario: Push
        Given I am a user with 200 dollars
        When I bet 10 dollars before a game
        And The game is a draw
        Then I should have 200 dollars
