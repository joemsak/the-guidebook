require 'rails_helper'

RSpec.describe "Public::ClientInvitations", type: :request do
  describe "GET /accept" do
    it "accepts the invitation" do
      invitation = create(:client_invitation)

      expect {
        get accept_public_client_invitation_path(invitation.id) # purposely avoiding friendly ID
      }.to change {
        invitation.reload.accepted?
      }.from(false).to(true)
    end
  end
end
