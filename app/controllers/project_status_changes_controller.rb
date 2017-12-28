# Audit log of all the project status changes
class ProjectStatusChangesController < ModerationController
  expose(:project_status_changes, -> { ProjectStatusChange.all.order(created_at: :desc) })
  def index; end
end
