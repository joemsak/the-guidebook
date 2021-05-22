Calendly.configure do |config|
  config.client_id = Rails.application.credentials.dig(:calendly, :client_id)
  config.client_secret = Rails.application.credentials.dig(:calendly, :client_secret)
end
