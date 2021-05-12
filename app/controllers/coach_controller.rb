class CoachController < ApplicationController
  before_action :authenticate_coach!

  private
  def authenticate_coach!
    if current_user && !current_coach
      redirect_to root_path, alert: t('alerts.unauthorized')
    else
      authenticate_user!
    end
  end

  def root_path_helper
    coach_dashboard_path
  end
end
