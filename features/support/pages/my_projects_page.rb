# Encapsulates user interactions with the My Projects Page
class MyProjectsPage < SitePrism::Page
  set_url "/my_projects"

  elements :_pending_projects, "*[data-type='pending-projects'] *[data-type=project]"
  elements :_approved_projects, "*[data-type='approved-projects'] *[data-type=project]"

  def approved_projects
    ElementCollection.new(_approved_projects)
  end

  def pending_projects
    ElementCollection.new(_pending_projects)
  end

  def showing_project?(project, status:)
    projects = projects_for_status(status)
    visible_project = projects.element_for(project)
    visible_project.present?
  end

  def projects_for_status(status)
    case status.to_sym
    when :approved
      approved_projects
    when :pending
      pending_projects
    else
      raise "Invalid status #{status}"
    end
  end
end
