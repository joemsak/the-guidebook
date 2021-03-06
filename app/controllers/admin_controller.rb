class AdminController < ApplicationController
  before_action :authenticate_admin!

  private
  def authenticate_admin!
    if current_user && !current_admin
      redirect_to root_path, alert: t('alerts.unauthorized')
    else
      authenticate_user!
    end
  end

  def root_path
    admin_dashboard_path
  end
end
