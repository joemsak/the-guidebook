class GuidebookCalendlyClient < Calendly::Client
  attr_accessor :config, :refresh_token

  API_HOST = 'https://api.calendly.com'
  AUTH_API_HOST = 'https://auth.calendly.com'

  def initialize(token, refresh_token, token_expires_at)
    @config = Calendly.configuration
    @token = token || Calendly.configuration.token

    config.refresh_token = refresh_token
    config.token_expires_at = token_expires_at

    check_token
  end

  def oauth_client
    OAuth2::Client.new(config.client_id, config.client_secret, client_options)
  end

  def client_options
    {
      site: API_HOST,
      authorize_url: "#{AUTH_API_HOST}/oauth/authorize",
      token_url: "#{AUTH_API_HOST}/oauth/token"
    }
  end

  def refresh!
    binding.pry
  end
end
