require "rails_helper"

RSpec.describe ClientInvitationMailer, type: :mailer do
  describe "invitation" do
    let(:invitation) { create(:client_invitation) }
    let(:mail) { ClientInvitationMailer.invitation(invitation.id) }

    it "renders the headers" do
      expect(mail.to).to eq([invitation.email])
      expect(mail.from).to eq([ApplicationMailer::DEFAULT_FROM])
      expect(mail.reply_to).to eq([invitation.sender_email])
    end

    it "renders the link with an unfriendly ID" do
      expect(mail.body.encoded).to match(accept_public_client_invitation_url(invitation.id))
    end
  end

end
