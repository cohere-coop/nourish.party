module Moderation
  # Audit log of all the moderator actions
  class ModeratorActionsController < ModerationController
    expose(:moderator_actions, -> { ModeratorAction.all.order(created_at: :desc) })
    def index; end
  end
end
