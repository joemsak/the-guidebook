Rails.application.config.middleware.use OmniAuth::Builder do
  provider :calendly,
    Rails.application.credentials.calendly[:client_id],
    Rails.application.credentials.calendly[:client_secret]
end
