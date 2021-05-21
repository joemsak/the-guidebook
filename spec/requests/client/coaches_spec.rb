require 'rails_helper'

RSpec.describe "Client::Coaches", type: :request do
  let(:client) { create(:client, :with_coach) }

  before { sign_in(client) }

  describe "GET /show" do
    it "returns http success" do
      coach = client.client_profile.coaches.last
      get client_coach_path(coach.slug)
      expect(response).to have_http_status(:success)
    end
  end
end
