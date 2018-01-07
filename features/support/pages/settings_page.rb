# The page people use to adjust settings and see their history
class SettingsPage < SitePrism::Page
  set_url "/users/edit"
  element :connect_slack_team_button, '*[data-action="new-slack-team"]'
  sections :_contributions, ContributionSection, '*[data-type="contribution"]'
  sections :_slack_teams, SlackTeamSection, '*[data-type="slack-team"]'

  def contributions
    ElementCollection.new(_contributions)
  end

  def slack_teams
    ElementCollection.new(_slack_teams)
  end

  def disconnect_slack_team(slack_team)
    slack_team_element = slack_teams.element_for(slack_team)
    slack_team_element.destroy_button.click
  end
end
