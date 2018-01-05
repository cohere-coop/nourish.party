Feature: Submitting a project
  Scenario: Before the project is approved
    Given I am signed in
    When I submit a project
    Then I am a member of the project
    And the project is not publicly available
    And I can see the project in my projects as pending

  Scenario: After the project is approved
    Given I am signed in
    And I had submitted a project
    When the project receives approval
    Then the project is publicly available
    And I can see the project in my projects as approved

  Scenario: After the project is rejected
    Given I am signed in
    And I had submitted a project
    When the project receives rejection
    Then the project is not publicly available
    And I can see the project in my projects as rejected

 Scenario: Guests may not submit projects
    Given I am not signed in
    When I begin to submit a project
    Then I am redirected to the sign in page
