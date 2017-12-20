# Represents the page used to log in to the application
# Encapsulates all login related functionality for feature tests
class LoginPage < SitePrism::Page
  set_url "/users/sign_in/"

  element :email_field, "input[name='user[email]']"
  element :password_field, "input[name='user[password]']"
  element :sign_in_button, "input[name='commit']"

  def submit(email:, password:)
    email_field.set(email)
    password_field.set(password)
    sign_in_button.click
  end
end
