require 'rails_helper'

RSpec.describe "User::Dashboards", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get user_dashboard_path
      expect(response).to redirect_to(signin_path)
    end
  end
end
