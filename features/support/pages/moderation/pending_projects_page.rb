module Moderation
  # Encapsulates user interactions with the new project page
  class PendingProjectsPage < SitePrism::Page
    set_url "/moderation/pending_projects"
    sections :_pending_projects, PendingProjectSection, "*[data-type='pending-project']"
    section :moderator_action_form, ModeratorActionFormSection, "*[data-type='moderator-action-form']"

    def pending_projects
      ElementCollection.new(_pending_projects)
    end

    def approve(project:, reason: "I just like it, OK?")
      project_to_approve = pending_projects.element_for(project)
      project_to_approve.begin_approval_button.click
      moderator_action_form.submit(reason: reason)
    end

    def t(*args, **kwargs)
      I18n.t(*args, **kwargs)
    end
  end
end
