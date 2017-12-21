# Encapsulates user interactions with home page
class HomePage < SitePrism::Page
  set_url "/"

  elements :projects, ".project"

  def project?(title:)
    projects.any? do |project|
      project.find(".title").text == title
    end
  end

  alias has_project? project?
end
