require "rails_helper"

RSpec.describe RegisteredUser, type: :model do
  describe "#instance_admin?" do
    it "defaults to false" do
      user = RegisteredUser.new
      expect(user).not_to be_instance_admin
    end

    it "may be updated to true" do
      user = RegisteredUser.new(instance_admin: true)
      expect(user).to be_instance_admin
    end
  end

  describe "#registered?" do
    it "is false for unpersisted users" do
      user = RegisteredUser.new
      expect(user).not_to be_registered
    end

    it "is true for persisted users" do
      user = FactoryBot.create(:registered_user)
      expect(user).to be_registered
    end
  end
end
