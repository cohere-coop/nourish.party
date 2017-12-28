module Moderation
  # Allows a project to be approved
  class ProjectApprovalsController < ModerationController
    expose(:project_approval, scope: -> { pending_project.moderator_actions }, model: :moderator_action)
    expose(:pending_project, scope: -> { Project.pending }, model: :project)

    def new; end

    def create
      if project_approval.save
        pending_project.approve
        redirect_to moderation_pending_projects_path
      else
        render :new
      end
    end

    private def project_approval_params
      params.require(:moderator_action).permit(:reason).merge(moderator: current_user, action: :approved)
    end
  end
end
