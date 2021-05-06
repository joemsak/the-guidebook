require 'rails_helper'

RSpec.describe Coach, type: :model do
  describe "#email" do
    it "must be unique" do
      coach1 = create(:coach)
      coach2 = create(:coach)

      coach2.email = coach1.email

      expect(coach2).not_to be_valid
    end
  end
end
