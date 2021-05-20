class ApplicationController < ActionController::Base
  AUTH_TOKEN_KEY = :auth_token
  CLIENT_INVITATION_KEY = :client_invitation_id
  BROWSING_SCOPE_KEY = :browsing_scope

  before_action :remember_browsing_scope

  helper_method :current_user, :current_admin, :current_coach, :current_client

  helper_method :navigating_admin?, :navigating_coach?

  helper_method :root_path_helper

  private
  def current_user
    @current_user ||= User.find_by(auth_token: cookies.signed[AUTH_TOKEN_KEY])
  end

  def current_admin
    current_user&.admin_profile
  end

  def current_coach
    current_user&.coach_profile
  end

  def current_client
    current_user&.client_profile
  end

  def root_path_helper
    root_path # See root app/controllers
  end

  def navigating_admin?
    params[:controller].starts_with?('admin/')
  end

  def navigating_coach?
    params[:controller].starts_with?('coach/')
  end

  def authenticate_user!
    unless current_user
      redirect_to signin_path, alert: t('alerts.unauthenticated')
    end
  end

  def sign_in(resource)
    if params[:remember_me]
      cookies.signed.permanent[AUTH_TOKEN_KEY] = resource.auth_token
    else
      cookies.signed[AUTH_TOKEN_KEY] = resource.auth_token
    end
  end

  def sign_out(resource)
    cookies.signed[AUTH_TOKEN_KEY] = nil
  end

  def require_no_authentication
    if current_user
      redirect_to user_dashboard_path, notice: t('notices.already_signed_in')
    end
  end

  def browsing_scope
    session[BROWSING_SCOPE_KEY] && session[BROWSING_SCOPE_KEY].to_sym
  end

  def remember_browsing_scope
    session[BROWSING_SCOPE_KEY] = browsing_scope_value
  end

  def browsing_scope_value
    if controller_name_parts.length > 1
      controller_name_parts[0]
    end
  end

  def controller_name_parts
    params[:controller].split('/')
  end
end
