Rails.application.config.middleware.use OmniAuth::Builder do
  provider :calendly,
    Rails.application.credentials.dig(:calendly, :client_id),
    Rails.application.credentials.dig(:calendly, :client_secret)
end
