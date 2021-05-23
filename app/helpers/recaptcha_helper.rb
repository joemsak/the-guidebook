module RecaptchaHelper
  RECAPTCHA_SITE_KEY = Rails.application.credentials.dig(:recaptcha, :site_key)

  def include_recaptcha_js
    return unless RECAPTCHA_SITE_KEY

    raw %Q{
      <script src="https://www.google.com/recaptcha/api.js?render=#{RECAPTCHA_SITE_KEY}"></script>
    }
  end

  def recaptcha_execute(action)
    return unless RECAPTCHA_SITE_KEY

    id = "recaptcha_token_#{SecureRandom.hex(10)}"

    raw %Q{
      <input name="recaptcha_token" type="hidden" id="#{id}"/>
      <script>
        grecaptcha.ready(function() {
          grecaptcha.execute('#{RECAPTCHA_SITE_KEY}', { action: '#{action}' })
            .then(function(token) {
              document.getElementById("#{id}").value = token;
            });
        });
      </script>
    }
  end
end
