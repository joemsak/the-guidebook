class User::OmniauthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    auth = current_user.authentications.find_or_create_by(
      provider: auth_hash.provider,
      uid: auth_hash.uid
    )

    auth.update(
      info: auth_hash.info,
      credentials: auth_hash.credentials,
      extra: auth_hash.extra
    )

    redirect_to user_dashboard_path,
      notice: t(".success", name: auth.provider.capitalize)
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end
