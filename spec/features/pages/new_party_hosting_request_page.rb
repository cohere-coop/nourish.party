class NewPartyHostingRequestPage < SitePrism::Page
  set_url "/party_hosting_requests/new"
  element :title_field, "input[name='party_hosting_request[title]']"
  element :activity_field, "input[name='party_hosting_request[activity]']"
  element :submit_button, "input[name='commit']"

  def submit(title:, activity:)
    title_field.set(title)
    activity_field.set(activity)
    submit_button.click
  end
end
