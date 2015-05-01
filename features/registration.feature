Feature: Registration
    In order to play blackjack
    As a visitor to the site
    I want to be able to register as a new user

    Scenario: Valid registration
        Given I register with a valid email and password
        Then I should be saved in the database

    Scenario: Invalid password
        Given I try to register an invalid password
        Then I should not be saved in the database

    Scenario: Starting money
        Given I register with a valid email and password
        Then I should have 200 dollars to start with
