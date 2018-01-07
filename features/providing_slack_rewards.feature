Feature: Providing Slack Rewards
  In order to encourage people to provide financial support
  As a project creator
  I want to offer access to a slack community as a reward

  Scenario: Connecting a Slack Team
    Given I am signed in
    And OmniAuth is stubbed to provide a successful Slack team connection
    When I connect a Slack team
    Then that Slack team is available to be offered as a reward for my projects
    And I can see that Slack team on my settings page


  Scenario: Disconnecting a Slack Team
    Given I am signed in
    And I have already connected a Slack team
    When I disconnect that slack team
    Then that Slack team is no longer available to be offered as a reward for my projects
    And I can not see that Slack team on my settings page
