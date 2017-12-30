# Base controller all app controllers should inherit from to ensure they inherit the correct settings
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  def current_user
    current_registered_user || GuestUser.new
  end
end
