# Encapsulates user interactions with home page
class HomePage < SitePrism::Page
  set_url "/"

  elements :projects, ".project"

  def has_project?(title:)
    projects.any? do |project|
      project.find(".title").text == title
    end
  end
end
