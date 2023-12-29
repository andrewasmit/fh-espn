# External Dependencies
require 'action_mailer'
require 'dotenv'

# Internal Dependencies
Dotenv.load('./.env')

# Define Mailer class
class Mailer < ActionMailer::Base
  default from: ENV['MY_EMAIL']

  def send_email(results)
    # body_content = "<strong><u>All Available Skaters Playing Today</u></strong>\n\n"
    # body_content += results.join("\n")

    mail(
      to: ENV['TEST_EMAIL'], 
      subject: "Andrew's Fantasy Hockey Sleepers", 
      # body: body_content,
      body: results.join("\n"),
      # content_type: "text/html"
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
