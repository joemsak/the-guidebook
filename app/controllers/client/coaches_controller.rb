class Client::CoachesController < ClientController
  def show
    @coach = current_client.coaches.friendly.find(params[:id])
  end
end
