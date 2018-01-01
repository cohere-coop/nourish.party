# Lists the current users projects
class MyProjectsController < ApplicationController
  before_action :authenticate_registered_user!

  expose :projects, -> { current_user.projects }

  def index; end
end
