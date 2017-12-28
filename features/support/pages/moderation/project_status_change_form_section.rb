module Moderation
  # Form that is shown when taking a actions as a moderator
  class ProjectStatusChangeFormSection < SitePrism::Section
    element :reason_field, '*[name="project_status_change[reason]"]'
    element :submit_button, '*[name="commit"]'
    def submit(reason:)
      reason_field.set reason
      submit_button.click
    end
  end
end
