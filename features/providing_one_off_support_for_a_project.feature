@wip
Feature: Providing One Off Support for a Project
  Background:
    Given there is an approved project connected to stripe
    And I am logged in
    And I have started to provide support for the approved project

  Scenario: When stripe approves the transaction
    Given stripe is rejecting payments
    When I submit the payment form with a valid credit card
    Then I am provided with confirmation that the payment went through
    And I can see the transaction in my transaction history
    And the stripe API was sent the transaction

  Scenario: When stripe rejects the transaction for internal reasons
    Given stripe is rejecting payments
    When I submit the payment form with a valid credit card
    Then the stripe API was sent the transaction
    And I am informed the payment did not process because of an internal error
    And I can not see the transaction in my transaction history

  Scenario: When the credit card is rejected
    Given stripe is accepting payments
    When I submit the payment form with an invalid credit card
    Then the stripe API was sent the transaction
    And I am informed that the payment did not process
    And I am informed the payment did not process because my card was rejected
    And I can not see the transaction in my transaction history

