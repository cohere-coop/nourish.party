Feature: Approving a Project
  In order for my projects to begin building support
  As a project creator
  I want admins to approve my project!

Scenario: Admin approves a project
  Given a project is pending
  And I sign in as an instance admin
  When I approve the project
  Then I see a notice that I approved the project
  And the project status changes log shows that I approved the project
  And the project is publicly available
  And the project is no longer pending
  And the project creator is sent a project approved email with my reason

Scenario: Non admin attempts to approve a project
  Given a project is pending
  And I sign in as a user
  When I attempt to approve the project
  Then I am forbidden from taking that action
  And the project is not publicly available
  And the project is still pending
