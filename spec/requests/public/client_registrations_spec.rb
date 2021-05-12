require 'rails_helper'

RSpec.describe "Public::ClientRegistrations", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/public/client_registrations/new"
      expect(response).to have_http_status(:success)
    end
  end

end
