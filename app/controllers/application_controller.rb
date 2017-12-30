# Base controller all app controllers should inherit from to ensure they inherit the correct settings
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    super || GuestUser.new
  end
end
