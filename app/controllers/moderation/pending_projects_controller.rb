module Moderation
  # Web page to approve/reject projects submitted by creators
  class PendingProjectsController < ModerationController
    expose(:pending_projects, -> { Project.pending })
    def index; end
  end
end
