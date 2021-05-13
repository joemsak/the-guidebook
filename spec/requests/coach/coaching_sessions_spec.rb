require 'rails_helper'

RSpec.describe "Coach::CoachingSessions", type: :request do
  let(:coach) { create(:coach) }

  before { sign_in(coach) }

  describe "GET /new" do
    it "returns http success" do
      get new_coach_coaching_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:coaching_session) { create(:coaching_session, coach: coach.coach_profile) }

    it "returns http success" do
      get coach_coaching_session_path(coaching_session)
      expect(response).to have_http_status(:success)
    end
  end
end
