require_relative "moderator_action_section"

module Moderation
  # PageObject for interacting with the moderator action log
  class ModeratorActionsPage < SitePrism::Page
    set_url "/moderation/moderator_actions"
    sections :_moderator_actions, ModeratorActionSection, '*[data-type="moderator-action"]'

    def moderator_actions
      ElementCollection.new(_moderator_actions)
    end
  end
end
