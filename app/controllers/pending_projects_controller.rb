# Interface for admins to review projects for approval/rejection
class PendingProjectsController < ModerationController
  expose(:pending_projects, -> { Project.pending })
  def index; end
end
