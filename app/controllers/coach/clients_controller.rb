class Coach::ClientsController < CoachController
  def index
    @clients = current_coach.clients
  end

  def show
    @client = User.clients_of(current_coach).friendly.find(params[:id])
  end
end
