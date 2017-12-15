describe "Signing into an account" do
  include FeatureTestHelpers
  it "allows you to log in" do
    User.create(email: "email@example.com", password: 'password')
    app.login_with(email: 'email@example.com', password: 'password')
    expect(app).not_to be_showing_errors
    expect(app).to be_logged_in_as('email@example.com')
  end
end
