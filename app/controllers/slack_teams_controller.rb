# Connects a user and project to a slack team
class SlackTeamsController < ApplicationController
  before_action :authenticate_registered_user!
  expose(:slack_teams, -> { current_user.slack_teams })
  expose(:slack_team, :find_or_initialize_slack_team)

  def create
    if slack_team.save
      slack_team.update(team_params)
      flash[:notice] = t("slack_teams.create.succeeded", name: slack_team.name)
    else
      flash[:alert] = t("slack_teams.create.failed")
    end
    redirect_to edit_registered_user_registration_url
  end

  def destroy
    slack_team = slack_teams.find(params[:id])
    if slack_team.destroy
      flash[:notice] = t("slack_teams.destroy.succeeded",
                         name: slack_team.name)
    else
      flash[:alert] = t("slack_teams.destroy.failed",
                        name: slack_team.name)
    end
    redirect_to edit_registered_user_registration_url
  end

  private def find_or_initialize_slack_team
    slack_teams.find_or_initialize_by(slack_id: team_data["id"])
  end

  private def team_params
    { name: team_data["name"], domain: team_data["domain"],
      access_token: omniauth_data["credentials"]["token"] }
  end

  private def omniauth_data
    request.env["omniauth.auth"]
  end

  private def team_data
    omniauth_data["extra"]["raw_info"]["team_info"]["team"]
  end

  private def omniauth_extra_data
    omniauth_data["extra"]["extra_info"]
  end
end
