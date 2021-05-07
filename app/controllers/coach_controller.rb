class CoachController < ApplicationController
  before_action :authenticate_coach!

  private
  def authenticate_coach!
    if current_user && !current_coach
      redirect_to root_path, alert: t('failures.unauthorized')
    else
      authenticate_user!
    end
  end
end
