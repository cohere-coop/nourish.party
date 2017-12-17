# Exposes CRUD actions for project requests
class ProjectRequestsController < ApplicationController
  expose :project_request, scope: -> { current_user.project_requests }
  def new; end

  def create
    current_user.project_requests << project_request
    if project_request.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def project_request_params
    params.require(:project_request).permit(:title, :summary)
  end
end
