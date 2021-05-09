class ClientInvitationMailer < ApplicationMailer
  def invitation(invitation_id)
    @client_invitation = ClientInvitation.find(invitation_id)

    begin
      @url = accept_public_client_invitation_url(invitation_id) # avoid friendly ID
      @sender = @client_invitation.sender
      mail to: @client_invitation.email, from: @sender.email
      @client_invitation.sent!
    rescue => e
      @client_invitation.failed_with_exception!(e)
      raise e
    end
  end
end
