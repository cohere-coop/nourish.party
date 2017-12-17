# Home page for the application
class DashboardController < ApplicationController
  expose :projects, -> { Project.all }
  before_action :authenticate_user!

  def index; end
end
