require "rails_helper"

RSpec.describe ClientInvitationMailer, type: :mailer do
  describe "invitation" do
    let(:invitation) { create(:client_invitation) }
    let(:mail) { ClientInvitationMailer.invitation(invitation.id) }

    it "renders the headers" do
      expect(mail.subject).to eq("Invitation to The Relationship Guidebook")
      expect(mail.to).to eq([invitation.email])
      expect(mail.from).to eq([invitation.sender_email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello there, #{invitation.name}!")
    end
  end

end
