class Public::ClientInvitationsController < PublicController
  def accept
    @client_invitation = ClientInvitation.find(params[:id])
    @client_invitation.accepted!
  end
end
