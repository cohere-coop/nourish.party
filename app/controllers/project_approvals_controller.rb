# Allows a project to be approved
class ProjectApprovalsController < ModerationController
  expose(:approval, scope: -> { project.project_status_changes },
                    model: :project_status_change)
  expose(:project, scope: -> { Project.pending }, model: :project)

  def new; end

  def create
    if project.apply_status_change(approval)
      flash[:notice] = t("approving_project.success_notification", project_title: project.title)
      redirect_to pending_projects_path
    else
      render :new
    end
  end

  private def approval_params
    params.require(:project_status_change)
      .permit(:reason).merge(moderator: current_user, action: :approved)
  end
end
