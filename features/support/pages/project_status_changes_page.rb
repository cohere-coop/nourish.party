# PageObject for interacting with the project status change log
class ProjectStatusChangesPage < SitePrism::Page
  set_url "/project_status_changes"
  sections :_project_status_changes, ProjectStatusChangeSection, '*[data-type="project-status-change"]'

  def project_status_changes
    ElementCollection.new(_project_status_changes)
  end
end
