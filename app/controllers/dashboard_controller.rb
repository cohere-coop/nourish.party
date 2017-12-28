# Home page for the application
class DashboardController < ApplicationController
  expose :projects, -> { Project.approved }

  def index; end
end
