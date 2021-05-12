class ClientController < ApplicationController
  before_action :authenticate_client!

  private
  def authenticate_client!
    if current_user && !current_client
      redirect_to root_path, alert: t('alerts.unauthorized')
    else
      authenticate_user!
    end
  end

  def root_path_helper
    client_dashboard_path
  end
end
