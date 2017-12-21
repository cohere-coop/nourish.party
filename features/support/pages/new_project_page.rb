# Encapsulates user interactions with the new project page
class NewProjectPage < SitePrism::Page
  set_url "/projects/new"
  element :title_field, "input[name='project[title]']"
  element :summary_field, "input[name='project[summary]']"
  element :submit_button, "input[name='commit']"

  def submit(title:, summary:)
    title_field.set(title)
    summary_field.set(summary)
    submit_button.click
  end
end
