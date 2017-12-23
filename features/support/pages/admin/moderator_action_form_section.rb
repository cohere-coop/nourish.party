module Admin
  # Form that is shown when taking a actions as a moderator
  class ModeratorActionFormSection < SitePrism::Section
    element :reason_field, '*[name="moderator_action[reason]"]'
    element :submit_button, '*[name="commit"]'
    def submit(reason:)
      reason_field.set reason
      submit_button.click
    end
  end
end
