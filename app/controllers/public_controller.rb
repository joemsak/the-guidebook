require 'net/https'

class PublicController < ApplicationController
  RECAPTCHA_MINIMUM_SCORE = 0.5

  skip_before_action :remember_browsing_scope

  before_action :require_no_authentication

  private
  def verify_recaptcha!(token)
    return unless Rails.application.credentials.dig(:recaptcha, :site_key)

    unless verify_recaptcha?(params[:recaptcha_token], token)
      flash.now[:alert] = t('alerts.recaptcha_error')
      render :new && return
    end
  end

  def verify_recaptcha?(token, recaptcha_action)
    response = Net::HTTP.get_response(recaptcha_uri(token))

    json = JSON.parse(response.body)

    json['success'] &&
      json['score'] > RECAPTCHA_MINIMUM_SCORE &&
        json['action'] == recaptcha_action
  end

  def recaptcha_uri(token)
    secret_key = Rails.application.credentials.dig(:recaptcha, :secret_key)
    URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
  end
end
