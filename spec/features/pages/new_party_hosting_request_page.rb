# Encapsulates user interactions with the new party hosting request page
class NewPartyHostingRequestPage < SitePrism::Page
  set_url "/party_hosting_requests/new"
  element :title_field, "input[name='party_hosting_request[title]']"
  element :summary_field, "input[name='party_hosting_request[summary]']"
  element :submit_button, "input[name='commit']"

  def submit(title:, summary:)
    title_field.set(title)
    summary_field.set(summary)
    submit_button.click
  end
end
