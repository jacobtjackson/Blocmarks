if Rails.env.development? || Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
      address:        'smtp.mailgun.net',
      port:           '2525',
      authentication: :plain,
      user_name:      ENV['MAILGUN_SMTP_LOGIN'],
      password:       ENV['MAILGUN_SMTP_PASSWORD'],
      domain:         'heroku.com',
      content_type: 'text/html'
  }

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.raise_delivery_errors = true

  class DevelopmentMailInterceptor
    def self.delivering_email(message)
      message.to =  'jacob.t.jackson@gmail.com'
      message.cc = nil
      message.bcc = nil
    end
  end

  if Rails.env.development?
    ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
  end
end