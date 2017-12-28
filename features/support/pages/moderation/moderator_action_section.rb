module Moderation
  # A entry in the moderator action logs
  class ModeratorActionSection < SitePrism::Section
    element :summary, "*[data-type=summary]"
    element :moderator, "*[data-type=moderator]"
    element :created_at, "*[data-type=taken-at]"

    def displaying?(moderator_action)
      moderator.has_text?(moderator_action.moderator.email) &&
        created_at.has_text?(moderator_action.created_at.to_s) &&
        displaying_summary?(moderator_action)
    end

    def displaying_summary?(moderator_action)
      summary.has_text?(moderator_action.action) &&
        summary.has_text?(moderator_action.reason) &&
        summary.has_text?(moderator_action.moderatable.title)
    end

    def id
      root_element[:"data-id"]
    end
  end
end
