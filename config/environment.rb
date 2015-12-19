# Load the rails application
require File.expand_path('../application', __FILE__)
ActionMailer::Base.smtp_settings = {
	:address => "smtp.sendgrid.net",     
    :port  => '587',       
    :domain => 'heroku.com'  
    :user_name  => ENV['SENDGRID_USERNAME']     
    :password   => ENV['SENDGRID_PASSWORD']     
    :authentication  => 'plain',     
    :raise_delivery_errors => true,     
    :enable_starttls_auto => true 
  }
# Initialize the rails application
HITCrs::Application.initialize!
