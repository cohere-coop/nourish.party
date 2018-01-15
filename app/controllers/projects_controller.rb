# Exposes CRUD actions for projects
class ProjectsController < ApplicationController
  before_action :authenticate_registered_user!

  expose :project, scope: -> { current_user.projects }
  def new; end

  def create
    current_user.project_memberships.create(project: project)
    if project.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    attributes = project_params
    attributes[:status] = :pending unless project.approved?
    if project.update(attributes)
      flash[:notice] = notice_for_update
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def notice_for_update
    if project.resubmitted?
      t("projects.update.resubmitted_notification", project: project.title)
    else
      t("projects.update.success_notification", project: project.title)
    end
  end

  def project_params
    params.require(:project).permit(:title, :summary)
  end
end
