require 'rails_helper'

RSpec.describe "Coach::Registrations", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get coach_signup_path
      expect(response).to have_http_status(:success)
    end
  end
end
