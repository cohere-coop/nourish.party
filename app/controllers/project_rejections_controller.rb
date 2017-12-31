# Allows a project to be rejected
class ProjectRejectionsController < ModerationController
  expose(:project_rejection, scope: -> { pending_project.project_status_changes },
                             model: :project_status_change)
  expose(:pending_project, scope: -> { Project.pending }, model: :project)

  def new; end

  def create
    ProjectStatusChange.transaction do
      pending_project.reject if project_rejection.save
    end

    if project_rejection.persisted?
      redirect_to pending_projects_path
    else
      render :new
    end
  end

  private def project_rejection_params
    params.require(:project_status_change)
      .permit(:reason).merge(moderator: current_user, action: :rejected)
  end
end
