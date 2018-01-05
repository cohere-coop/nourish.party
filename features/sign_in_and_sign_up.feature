Feature: Sign in and Sign up

  Scenario: User can sign up
    When I sign up with the email "unique-email@example.com" and the password "password"
    Then I should not see any errors
    And I should not be signed in
    And I should be asked to confirm my account

  Scenario: User cannot sign up with an email address that already exists
    Given there is already a user with the email "taken-email@example.com"
    When I sign up with the email "taken-email@example.com" and the password "password"
    Then I should see an error saying that the email has been taken
    And I should not be signed in

  Scenario: User must provide email and password when signing up
    When I sign up with the email "" and the password ""
    Then I should see an error saying that an email is required
    And I should see an error saying that a password is required
    And I should see an error saying that a password confirmation is required

  Scenario: User can sign in to an existing account
    Given there is already a user with the email "taken-email@example.com" and the password "password"
    When I sign in as "taken-email@example.com" using the password "password"
    Then I should not see any errors
    And I should be signed in as "taken-email@example.com"

  Scenario: User can sign out
    Given I am signed in
    When I sign out
    Then I should not be signed in

