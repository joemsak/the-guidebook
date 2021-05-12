require 'rails_helper'

RSpec.describe "Public::Welcomes", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

end
