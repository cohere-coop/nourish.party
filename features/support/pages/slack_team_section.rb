# A single slack team
class SlackTeamSection < SitePrism::Section
  element :destroy_button, "*[data-action=destroy-slack-team]"

  def displaying?(slack_team)
    root_element.has_text?(slack_team.name)
  end
end
