class ApplicationMailer < ActionMailer::Base
  DEFAULT_FROM = 'support@relationalguidebook.com'

  default from: DEFAULT_FROM

  layout 'mailer'
end
