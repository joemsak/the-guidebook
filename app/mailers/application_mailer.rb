class ApplicationMailer < ActionMailer::Base
  SUPPORT_EMAIL = "support@relationalguidebook.com"
  DEFAULT_FROM = "#{I18n.t('site.title')} <#{SUPPORT_EMAIL}>"

  default from: DEFAULT_FROM

  layout 'mailer'
end
