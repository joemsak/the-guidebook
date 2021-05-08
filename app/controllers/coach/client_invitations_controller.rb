class Coach::ClientInvitationsController < CoachController
  before_action :set_client_invitation, except: %i[index new create]

  def index
    @client_invitations = current_coach.client_invitations
  end

  def new
    @client_invitation = current_coach.client_invitations.build
  end

  def create
    @client_invitation = current_coach.client_invitations.build(client_invitation_params)

    if @client_invitation.save
      redirect_to [:coach, @client_invitation], notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @client_invitation.update(client_invitation_params)
      redirect_to [:coach, @client_invitation], notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @client_invitation.destroy
    redirect_to [:coach, :client_invitations], notice: t('.success')
  end

  private
  def set_client_invitation
    @client_invitation = current_coach.client_invitations.friendly.find(params[:id])
  end

  def client_invitation_params
    params.require(:client_invitation).permit(:name, :email)
  end
end
