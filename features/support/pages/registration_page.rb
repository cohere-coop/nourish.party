# Represents the page used to register for the application. Encapsulates all registration functionality for
# feature tests.
class RegistrationPage < SitePrism::Page
  set_url "/users/sign_up/"

  element :email_field, "input[name='user[email]']"
  element :password_field, "input[name='user[password]']"
  element :confirm_password_field, "input[name='user[password_confirmation]']"
  element :sign_up_button, "input[name='commit']"

  def submit(email:, password:, confirm_password: nil)
    email_field.set(email)
    password_field.set(password)
    confirm_password_field.set(confirm_password || password)
    sign_up_button.click
  end
end
