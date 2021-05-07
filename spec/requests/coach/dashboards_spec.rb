require 'rails_helper'

RSpec.describe "Coach::Dashboards", type: :request do
  before { sign_in(:coach) }

  describe "GET /show" do
    it "returns http success" do
      get coach_dashboard_path
      expect(response).to have_http_status(:success)
    end
  end
end
