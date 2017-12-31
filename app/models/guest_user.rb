# For users who aren't logged in
class GuestUser
  def instance_admin?
    false
  end

  def registered?
    false
  end
end
