# Encapsulates user interactions with the My Projects Page
class MyProjectsPage < SitePrism::Page
  set_url "/my_projects"

  elements :_approved_projects, "*[data-status='approved'][data-type=project]"
  elements :_pending_projects, "*[data-status='pending'][data-type=project]"
  elements :_rejected_projects, "*[data-status='rejected'][data-type=project]"

  def approved_projects
    ElementCollection.new(_approved_projects)
  end

  def pending_projects
    ElementCollection.new(_pending_projects)
  end

  def rejected_projects
    ElementCollection.new(_rejected_projects)
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
    when :rejected
      rejected_projects
    else
      raise "Invalid status #{status}"
    end
  end
end
