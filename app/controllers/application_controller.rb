class ApplicationController < ActionController::Base
  AUTH_TOKEN = :auth_token

  helper_method :current_coach

  private
  def current_coach
    @current_coach ||= Coach.find_by(auth_token: cookies.signed[AUTH_TOKEN])
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
