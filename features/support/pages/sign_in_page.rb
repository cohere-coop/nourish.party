# Encapsulates sign in functionality for feature tests
class SignInPage < SitePrism::Page
  set_url "/users/sign_in/"

  element :email_field, "input[name='registered_user[email]']"
  element :password_field, "input[name='registered_user[password]']"
  element :sign_in_button, "input[name='commit']"

  def submit(email:, password:)
    email_field.set(email)
    password_field.set(password)
    sign_in_button.click
  end
end
