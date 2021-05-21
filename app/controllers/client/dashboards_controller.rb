class Client::DashboardsController < ClientController
  def show
    @latest_coaching_session = current_client.coaching_sessions.completed.last
  end
end
