class Mailer < ActionMailer::Base   
	default from: "no-reply@heroku.com"  
	def confirmation(applicant)     
		@applicant = applicant     
		mail(:to => "#{@applicant.name} <#{@applicant.email}>",
		     :subject => "HITCRS Registration Confirmation")   
	end
end 
