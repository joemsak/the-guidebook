class AdminController < ApplicationController
  before_action :authenticate_admin!

  private
  def authenticate_admin!
    if current_user && !current_admin
      redirect_to root_path, alert: t('failures.unauthorized')
    else
      authenticate_user!
    end
  end
end
