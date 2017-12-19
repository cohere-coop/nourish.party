# Exposes CRUD actions for projects
class ProjectsController < ApplicationController
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

  private

  def project_params
    params.require(:project).permit(:title, :summary)
  end
end
