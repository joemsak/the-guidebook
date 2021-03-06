class Public::ClientRegistrationsController < PublicController
  def new
    @client = User.new
    attach_possible_client_invitation(@client)
  end

  def create
    verify_recaptcha!('client_signup')

    ActiveRecord::Base.transaction do
      @client = User.new(client_params)

      if @client.save
        @client.create_client_profile!
        attach_possible_client_invitation(@client)
        session.delete(CLIENT_INVITATION_KEY)
        sign_in(@client)
        redirect_to client_dashboard_path, notice: t('.success')
      else
        render :new
      end
    end
  end

  private
  def client_params
    params.require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end

  def attach_possible_client_invitation(client)
    if client_invitation = load_client_invitation(client)
      client.name = client_invitation.name
      client.email = client_invitation.email

      if client.persisted?
        client.client_profile.invitations << client_invitation
        client_invitation.completed!
      end
    end
  end

  def load_client_invitation(client)
    if session[CLIENT_INVITATION_KEY]
      ClientInvitation.find(session[CLIENT_INVITATION_KEY])
    elsif client.email
      ClientInvitation.find_by(email: client.email)
    end
  end
end
