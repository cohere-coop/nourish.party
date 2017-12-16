require 'features/helper'

describe "Registering an user" do
  include FeatureTestHelpers
  it "allows a user to sign up" do
    app.register_with(email: 'unique-email@example.com', password: 'password')
    expect(app).not_to be_showing_errors
    expect(app).to be_logged_in_as('unique-email@example.com')
  end

  it "prevents a user from registering with an already existing email address" do
    User.create(email: "taken-email@example.com", password: 'password')
    app.register_with(email: 'taken-email@example.com', password: 'password')
    expect(app).to be_showing_errors
    expect(app).to be_showing_error('activerecord.attributes.user.email', 'errors.messages.taken')
    expect(app).to be_showing_error('activerecord.attributes.user.email', 'errors.messages.taken')
    expect(app).not_to be_logged_in_as('unique-email@example.com')
  end

  it "prevents a user from registering without any information" do
    app.register_with(email: '', password: '')
    expect(app).to be_showing_errors
    expect(app).to be_showing_error('activerecord.attributes.user.email', 'errors.messages.required')
    expect(app).to be_showing_error('activerecord.attributes.user.password', 'errors.messages.required')
    expect(app).to be_showing_error('activerecord.attributes.user.password_confirmation', 'errors.messages.required')
    expect(app).not_to be_logged_in_as('unique-email@example.com')
  end
end
