module Admin
  # Base controller all app controllers should inherit from to ensure they inherit the correct settings
  class AdminController < ApplicationController
    protect_from_forgery with: :exception
    before_action :forbid_non_instance_admins

    def forbid_non_instance_admins
      render :forbidden, status: :forbidden unless current_user.instance_admin?
    end
  end
end
