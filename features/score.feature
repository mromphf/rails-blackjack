Feature: Scores
    In order to beat the dealer and win chips
    As a player
    I want to be dealt cards to accumulate a score

    Scenario: Add three cards to form a score
        When the dealer deals me a 5 of hearts
        And the dealer deals me a 11 of clubs
        And the dealer deals me a 2 of spades
        Then I should have a total score of 18
