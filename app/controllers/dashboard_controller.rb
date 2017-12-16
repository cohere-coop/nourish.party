# Home page for the application
class DashboardController < ApplicationController
  expose :parties, -> { Party.all }
  before_action :authenticate_user!

  def index; end
end
