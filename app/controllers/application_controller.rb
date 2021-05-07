class ApplicationController < ActionController::Base
  AUTH_TOKEN = :auth_token

  helper_method :current_admin, :current_coach, :current_client

  private
  def current_admin
    current_user&.admin_profile
  end

  def current_coach
    current_user&.coach_profile
  end

  def current_client
    current_user&.client_profile
  end

  def current_user
    @current_user ||= User.find_by(auth_token: cookies.signed[AUTH_TOKEN])
  end

  def authenticate_user!
    unless current_user
      redirect_to signin_path, alert: t('failures.unauthenticated')
    end
  end

  def sign_in(resource)
    if params[:remember_me]
      cookies.signed.permanent[AUTH_TOKEN] = resource.auth_token
    else
      cookies.signed[AUTH_TOKEN] = resource.auth_token
    end
  end

  def sign_out(resource)
    cookies.signed[AUTH_TOKEN] = nil
  end
end
