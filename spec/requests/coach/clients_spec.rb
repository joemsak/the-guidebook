require 'rails_helper'

RSpec.describe "Coach::Clients", type: :request do
  before { sign_in(:coach) }

  describe "GET /index" do
    it "returns http success" do
      get coach_clients_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      client = create(:client, coach: CoachProfile.last)
      get coach_client_path(client.slug)
      expect(response).to have_http_status(:success)
    end
  end
end
