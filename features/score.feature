Feature: Scores
    In order to beat the dealer and win chips
    As a player
    I want to be dealt cards to accumulate a score

    Scenario: Add three cards to form a score
        Given I am a player
        When the dealer deals me a 5 of hearts
        And the dealer deals me a 10 of clubs
        And the dealer deals me a 2 of spades
        Then I should have a total score of 17

    Scenario: Add two cards to form blackjack
        Given I am a player
        When the dealer deals me a jack of clubs
        And the dealer deals me an ace of hearts
        Then I should have blackjack

    Scenario: Add two face cards for a score of twenty
        Given I am a player
        When the dealer deals me a king of diamonds
        And the dealer deals me a queen of clubs
        Then I should have a total score of 20

    Scenario: Bust
        Given I am a player
        When the dealer deals me a king of hearts
        And the dealer deals me a 10 of diamonds
        And the dealer deals me a 5 of clubs
        Then I should bust

    Scenario: Aces low
        Given I am a player
        When the dealer deals me an ace of hearts
        And the dealer deals me a 5 of clubs
        And the dealer deals me a jack of clubs
        Then I should have a total score of 16

    Scenario: Aces high with face card
        Given I am a player
        When the dealer deals me an ace of hearts
        And the dealer deals me a jack of clubs 
        Then I should have a total score of 21

    Scenario: Aces high without face card
        Given I am a player
        When the dealer deals me a 5 of clubs 
        And the dealer deals me a 4 of hearts 
        And the dealer deals me an ace of hearts
        Then I should have a total score of 20

    Scenario: One low ace one high ace
        Given I am a player
        When the dealer deals me a 8 of hearts
        And the dealer deals me an ace of hearts
        And the dealer deals me an ace of spades
        Then I should have a total score of 20

    Scenario: Ace with a non-face card
        Given I am a player
        When the dealer deals me a 8 of hearts
        And the dealer deals me an ace of hearts
        Then I should have a total score of 19
