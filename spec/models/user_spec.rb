require "rails_helper"

RSpec.describe User, type: :model do
  describe "#instance_admin?" do
    it "defaults to false" do
      user = User.new
      expect(user).not_to be_instance_admin
    end

    it "may be updated to true" do
      user = User.new(instance_admin: true)
      expect(user).to be_instance_admin
    end
  end
end
