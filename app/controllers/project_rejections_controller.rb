# Allows a project to be rejected
class ProjectRejectionsController < ModerationController
  expose(:rejection, scope: -> { project.project_status_changes },
                     model: :project_status_change)
  expose(:project, scope: -> { Project.pending }, model: :project)

  def new; end

  def create
    if project.apply_status_change(rejection)
      flash[:notice] = t("rejecting_project.success_notification", project_title: project.title)
      redirect_to pending_projects_path
    else
      render :new
    end
  end

  private def rejection_params
    params.require(:project_status_change)
      .permit(:reason).merge(moderator: current_user, action: :rejected)
  end
end
