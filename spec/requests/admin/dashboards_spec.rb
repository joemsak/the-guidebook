require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  before { sign_in(:admin) }

  describe "GET /show" do
    it "returns http success" do
      get admin_dashboard_path
      expect(response).to have_http_status(:success)
    end
  end
end
