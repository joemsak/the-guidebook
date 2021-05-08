require 'rails_helper'

RSpec.describe "Coach::ClientInvitations", type: :request do
  describe "GET /new" do
    before { sign_in(:coach) }

    it "returns http success" do
      get new_coach_client_invitation_path
      expect(response).to have_http_status(:success)
    end
  end
end
