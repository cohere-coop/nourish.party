# Encapsulates user interactions with the new project request page
class NewProjectRequestPage < SitePrism::Page
  set_url "/project_requests/new"
  element :title_field, "input[name='project_request[title]']"
  element :summary_field, "input[name='project_request[summary]']"
  element :submit_button, "input[name='commit']"

  def submit(title:, summary:)
    title_field.set(title)
    summary_field.set(summary)
    submit_button.click
  end
end
