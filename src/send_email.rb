# External Dependencies
require 'action_mailer'
require 'dotenv'

# Internal Dependencies
Dotenv.load('./.env')

# Define Mailer class
class MyCustomMailer < ActionMailer::Base
  default from: ENV['MY_EMAIL']

  def send_email(recipient_email_address)
    mail(
      to: recipient_email_address, 
      subject: "Hello from Andrew's Fantasy Hockey Script", 
      body: 'This is a test email sent using ActionMailer!'
      )
  end
end

# Configure Mailer settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'gmail.com',
  user_name: ENV['MY_EMAIL'],
  password: ENV['MY_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true
}

recipient_email = ENV['TEST_EMAIL']
MyCustomMailer.send_email(recipient_email).deliver_now
