require "rails_helper"

RSpec.describe GuestUser, type: :model do
  describe "#registered?" do
    it "is never true" do
      user = GuestUser.new
      expect(user).not_to be_registered
    end
  end

  describe "#instance_admin?" do
    it "is never true" do
      user = GuestUser.new
      expect(user).not_to be_instance_admin
    end
  end
end
