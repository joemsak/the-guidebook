class Public::ClientInvitationsController < PublicController
  def accept
    @client_invitation = ClientInvitation.find(params[:id])
    @client_invitation.accepted!

    session[CLIENT_INVITATION_KEY] = params[:id]

    redirect_to client_signup_path, notice: t('.success')
  end
end
