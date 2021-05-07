class AdminController < ApplicationController
  private
  def authenticated_admin!
    if current_user && !current_admin
      redirect_to root_path, alert: t('failures.unauthorized')
    else
      authenticate_user!
    end
  end
end
