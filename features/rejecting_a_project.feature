Feature: Rejecting a Project
  In order to keep the community focused
  As an instance admin
  I want to be able to reject projects

Scenario: Admin rejects a project
  Given a project is pending
  And I sign in as an instance admin
  When I reject the project
  Then the project status changes log shows that I rejected the project
  And the project is not publicly available
  And the project is no longer pending

Scenario: Non admin attempts to reject a project
  Given a project is pending
  And I sign in as a user
  When I attempt to reject the project
  Then I am forbidden from taking that action
  And the project is not publicly available
  And the project is still pending
