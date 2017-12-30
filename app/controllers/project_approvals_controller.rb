# Allows a project to be approved
class ProjectApprovalsController < ModerationController
  expose(:project_approval, scope: -> { pending_project.project_status_changes },
                            model: :project_status_change)
  expose(:pending_project, scope: -> { Project.pending }, model: :project)

  def new; end

  def create
    ProjectStatusChange.transaction do
      pending_project.approve if project_approval.save
    end

    if project_approval.persisted?
      redirect_to pending_projects_path
    else
      render :new
    end
  end

  private def project_approval_params
    params.require(:project_status_change)
      .permit(:reason).merge(moderator: current_user, action: :approved)
  end
end
