class User::DashboardsController < ApplicationController
  before_action :redirect_to_profile

  private
  def redirect_to_profile
    if current_admin
      redirect_to [:admin, :dashboard]
    elsif current_coach
      redirect_to [:coach, :dashboard]
    elsif current_client
      redirect_to [:client, :dashboard]
    else
      redirect_to signin_path
    end
  end
end
