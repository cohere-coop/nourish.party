Feature: Submitting a project
  Scenario: Before the project is approved
    Given I am signed in
    When I submit a project titled "Space Unicorns" and summarized as "Ride a space unicorn!"
    Then there is not a public project titled "Space Unicorns" and summarized as "Ride a space unicorn!"
    And I am a member of the project titled "Space Unicorns"

  Scenario: After the project is approved
    Given I am signed in
    And I submit a project titled "Space Unicorns" and summarized as "Ride a space unicorn!"
    When the project titled "Space Unicorns" is approved
    Then there is a public project titled "Space Unicorns" and summarized as "Ride a space unicorn!"
    And I am a member of the project titled "Space Unicorns"


 Scenario: Guests may not submit projects
    Given I am not signed in
    When I begin to submit a project
    Then I am redirected to the sign in page
