Feature: Approving a Project
  In order for my projects to begin building support
  As a project creator
  I want admins to approve my project!

Scenario: Admin approves a project
  Given a project is pending
  And I am signed in as an instance admin
  When I approve the project
  Then the moderator actions log shows that I approved the project
  And the project is publicly available on the website
  And the project is no longer available to be approved
  And the project members receive a confirmation email

Scenario: Creative attempts to approve a project
  Given a project is pending
  And I am signed in as a creative
  When I attempt to approve the project
  Then I am rejected as unauthorized

Scenario: Supporter attempts to approve a project
  Given a project is pending
  And I am signed in as a Supporter
  When I attempt to approve the project
  Then I am rejected as unauthorized
