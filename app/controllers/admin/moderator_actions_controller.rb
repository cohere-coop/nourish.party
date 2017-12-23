module Admin
  # Audit log of all the moderator actions
  class ModeratorActionsController < AdminController
    expose(:moderator_actions, -> { ModeratorAction.all.order(created_at: :desc) })
    def index; end
  end
end
