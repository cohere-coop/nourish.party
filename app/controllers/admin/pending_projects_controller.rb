module Admin
  # Web page to approve/reject projects submitted by creators
  class PendingProjectsController < AdminController
    expose(:pending_projects, -> { Project.pending })
    def index; end
  end
end
