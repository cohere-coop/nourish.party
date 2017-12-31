# Encapsulates user interactions with the new project page
class PendingProjectsPage < SitePrism::Page
  set_url "/pending_projects"
  sections :_pending_projects, PendingProjectSection, "*[data-type='project']"
  section :project_status_change_form, ProjectStatusChangeFormSection,
          "*[data-type='project-status-change-form']"

  def pending_projects
    ElementCollection.new(_pending_projects)
  end

  def approve(project:, reason: "I just like it, OK?")
    project_to_approve = pending_projects.element_for(project)
    project_to_approve.begin_approval_button.click
    project_status_change_form.submit(reason: reason)
  end

  def reject(project:, reason: "I don't like it")
    project_to_reject = pending_projects.element_for(project)
    project_to_reject.begin_rejection_button.click
    project_status_change_form.submit(reason: reason)
  end

  def t(*args, **kwargs)
    I18n.t(*args, **kwargs)
  end
end
