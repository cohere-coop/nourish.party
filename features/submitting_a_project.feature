Feature: Submitting a project
  Scenario: Before the project is approved
    Given I am signed in
    When I submit a project
    Then I am a member of the project
    And the project is not publicly available
    And I can see the project in my projects as pending

  Scenario: After the project is approved
    Given I am signed in
    And I had submitted a project that is currently pending
    When the project receives approval
    Then the project is publicly available
    And I can see the project in my projects as approved

  Scenario: After the project is rejected
    Given I am signed in
    And I had submitted a project that is currently pending
    When the project receives rejection
    Then the project is not publicly available
    And I can see the project in my projects as rejected

 Scenario: Guests may not submit projects
    Given I am not signed in
    When I begin to submit a project
    Then I am redirected to the sign in page

  Scenario: Updating a rejected project
    Given I am signed in
    And I had submitted a project that is currently rejected
    When I change the project
    Then the project reflects my changes
    And I see a notice that the project has been resubmitted for approval
    And I can see the project in my projects as pending
    And the project is not publicly available

  Scenario: Updating a pending project
    Given I am signed in
    And I had submitted a project that is currently pending
    When I change the project
    Then the project reflects my changes
    And I see a notice that the project has been updated
    And I can see the project in my projects as pending
    And the project is not publicly available

  Scenario: Updating an approved project
    Given I am signed in
    And I had submitted a project that is currently approved
    When I change the project
    Then the project reflects my changes
    And I see a notice that the project has been updated
    And I can see the project in my projects as approved
    And the project is publicly available

