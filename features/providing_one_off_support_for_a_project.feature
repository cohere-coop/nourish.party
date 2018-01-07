Feature: Providing One Off Support for a Project
  Background:
    Given an approved project connected to stripe
    # We'll want to remove registration as a prerequisite in a later story.
    And I am signed in

  Scenario: When stripe approves the transaction
    Given I have never provided support before
    When I provide one off support for the project with a valid credit card
    Then the stripe API was sent the transaction
    And I am shown that the payment went through
    And I can see the transaction in my transaction history

  Scenario: When stripe rejects the transaction for internal reasons
    Given stripe is rejecting payments
    When I provide one off support for the project with a valid credit card
    Then the stripe API was sent the transaction
    And I am shown that the payment did no go through through because of an internal error
    And I can not see the transaction in my transaction history

  Scenario: When the credit card is rejected
    When I provide one off support for the project with an invalid credit card
    Then the stripe API was sent the transaction
    And I am shown that the payment did no go through through because my card was rejected
    And I can not see the transaction in my transaction history

