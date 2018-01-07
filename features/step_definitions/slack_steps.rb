Given("OmniAuth is stubbed to provide a successful Slack team connection") do
  OmniAuth.config.mock_auth[:slack] = OmniAuth::AuthHash.new(
    provider: "slack",
    credentials: {
      token: "slack-123456"
    },
    extra: {
      raw_info: { team_info: { team: { name: "example team", domain: "example-team" } } }
    }
  )
end

Given("I have already connected a Slack team") do
  create(:slack_team, owner: app.current_user)
end

When("I disconnect that slack team") do
  app.visit(:settings_page)
  current_page.disconnect_slack_team(app.current_user.slack_teams.first)
end

When("I connect a Slack team") do
  app.visit(:settings_page)
  current_page.connect_slack_team_button.click
end

Then("that Slack team is available to be offered as a reward for my projects") do
  expect(app.current_user.slack_teams).to be_present
end

Then("I can see that Slack team on my settings page") do
  app.visit(:settings_page)
  expect(app.current_page.slack_teams).to be_displaying(*app.current_user.slack_teams)
end

Then("that Slack team is no longer available to be offered as a reward for my projects") do
  expect(app.current_user.slack_teams).to be_empty
end

Then("I can not see that Slack team on my settings page") do
  expect(app.current_page.slack_teams).to be_empty
end
