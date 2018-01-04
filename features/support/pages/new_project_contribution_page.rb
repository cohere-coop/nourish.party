# Encapsulates user interactions with the contribution page
class NewProjectContributionPage < SitePrism::Page
  set_url "/projects/{project_id}/contributions/new"

  def self.text_element(name, i18n_key)
    xpath = format('//*[contains(text(), "%<text>s")]', text: I18n.t(i18n_key))
    element name, :xpath, xpath
  end

  text_element :not_ready_yet_message, "contributions.new.not_connected_to_payment_processor"
  text_element :ready_for_contributions_message, "contributions.new.ready_to_take_payments"

  element :payment_processor_token_field, "#contribution_payment_processor_attributes_token"
  element :amount_field, "#contribution_amount_in_dollars"
  element :submit_button, "input[type=submit]"

  def make_one_off_contribution(credit_card:, amount:)
    payment_processor_token_field.set("tok_visa")
    amount_field.set(amount.dollars)
    submit_button.click
  end
end
