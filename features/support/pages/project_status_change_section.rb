# A entry in the moderator action logs
class ProjectStatusChangeSection < SitePrism::Section
  element :summary, "*[data-type=summary]"
  element :moderator, "*[data-type=moderator]"
  element :created_at, "*[data-type=taken-at]"

  def displaying?(project_status_change)
    moderator.has_text?(project_status_change.moderator.email) &&
      created_at.has_text?(project_status_change.created_at.to_s) &&
      displaying_summary?(project_status_change)
  end

  def displaying_summary?(project_status_change)
    summary.has_text?(project_status_change.action) &&
      summary.has_text?(project_status_change.reason) &&
      summary.has_text?(project_status_change.project.title)
  end

  def id
    root_element[:"data-id"]
  end
end
