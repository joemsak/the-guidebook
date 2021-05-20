class User::DashboardsController < UserController
  before_action :redirect_to_profile

  def show; end

  private
  def redirect_to_profile
    if browsing_scope
      redirect_to [browsing_scope, :dashboard]
    elsif current_admin
      redirect_to [:admin, :dashboard]
    elsif current_coach
      redirect_to [:coach, :dashboard]
    elsif current_client
      redirect_to [:client, :dashboard]
    else
      redirect_to root_path
    end
  end
end
