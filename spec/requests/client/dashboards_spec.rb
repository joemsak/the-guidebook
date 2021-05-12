require 'rails_helper'

RSpec.describe "Client::Dashboards", type: :request do
  describe "GET /show" do
    before { sign_in(:client) }

    it "returns http success" do
      get client_dashboard_path
      expect(response).to have_http_status(:success)
    end
  end
end
