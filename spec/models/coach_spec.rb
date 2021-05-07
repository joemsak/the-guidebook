require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#email" do
    it "must be unique" do
      user1 = create(:user)
      user2 = create(:user)

      user2.email = user1.email

      expect(user2).not_to be_valid
    end
  end
end
