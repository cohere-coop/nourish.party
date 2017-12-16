require "rails_helper"

RSpec.describe PartyHostingRequest, type: :model do
  subject(:party_hosting_request) { create(:party_hosting_request, hosts: [create(:user)]) }
  describe "#approve" do
    it "creates a party with the same title, summary and hosts from the party hosting request" do
      party_hosting_request.approve
      resulting_party = party_hosting_request.resulting_party
      expect(resulting_party).to be_persisted
      expect(resulting_party.title).to eq party_hosting_request.title
      expect(resulting_party.summary).to eq party_hosting_request.summary
      expect(resulting_party.hosts).to eq party_hosting_request.hosts
    end

    it "archives the party hosting request" do
      party_hosting_request.approve
      expect(party_hosting_request).to be_archived
    end

    context "when the party hosting request already has a resulting party" do
      before { party_hosting_request.approve }
      it "is does not create another party if the party hosting request already has a resulting party" do
        expect { party_hosting_request.approve }.not_to change(Party, :count)
      end

      it "is returns false if the party hosting request already has a resulting party" do
        expect(party_hosting_request.approve).to be false
      end
    end
  end
end
