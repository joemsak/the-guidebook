class ClientInvitationMailer < ApplicationMailer
  def invitation(invitation_id)
    @client_invitation = ClientInvitation.find(invitation_id)

    begin
      mail to: @client_invitation.email, from: @client_invitation.sender_email
      @client_invitation.sent!
    rescue => e
      @client_invitation.update(
        status: :failed,
        failure: { message: e.message, backtrace: e.backtrace }
      )

      raise e
    end
  end
end
