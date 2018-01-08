Feature: Contributing to a project

  Scenario: Project has no valid payment processors (visitor)
    Given an approved project that does not have any valid payment processor connections exists
    And I am a potential contributor to that project
    When I visit that project's contribution page
    Then I should see a message telling me that the project is not ready to accept contributions

  Scenario: Project has no valid payment processors (member)
    Given an approved project that does not have any valid payment processor connections exists
    And I am a member of that project
    When I visit that project's contribution page
    Then I should see a message telling me that the project is not ready to accept contributions
    And I should see a link to connect a payment processor

  Scenario: Project has a valid payment processor
    Given an approved project with valid payment processor connections exists
    When I visit that project's contribution page
    Then I should be able to contribute to that project
