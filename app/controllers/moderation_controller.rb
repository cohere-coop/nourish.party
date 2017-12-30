# Parent controller for controllers only accessible to moderators
class ModerationController < ApplicationController
  before_action :forbid_non_instance_admins

  def forbid_non_instance_admins
    render :forbidden, status: :forbidden unless current_registered_user.instance_admin?
  end
end
