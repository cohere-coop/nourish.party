xdescribe "Requesting to host a party spec" do
  include FeatureTestHelpers
  it "requires the party to be approved before it becomes visible" do
    user = create(:user)
    app.login_as(user: user)
    app.submit_party_hosting_request(title: "Robotic Pidgeons",
                                     activity: "We're designing robotic pigeons and letting them loose")

    expect(app).not_to have_public_party(title: "Robotic Pidgeons")

    party_hosting_request = PartyHostingRequest.find_by(title: "Robotic Pidgeons")
    expect(party_hosting_request.hosts).to include(user)
    party_hosting_request.approve
    expect(party_hosting_request.resulting_party).to be_persisted
    expect(party_hosting_request.resulting_party.hosts).to include(user)

    expect(app).to have_public_party(title: "Robotic Pidgeons")
  end
end
