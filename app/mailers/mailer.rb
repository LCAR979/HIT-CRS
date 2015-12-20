class Mailer < ActionMailer::Base   
	default from: "no-reply@heroku.com"  
	def applicant_confirmation(applicant)     
		@applicant = applicant     
		mail(:to => "#{@applicant.name} <#{@applicant.email}>",
		     :subject => "HITCRS Registration Confirmation")   
	end
	
	def staff_confirmation(staff)     
		@staff = staff 
		mail(:to => "#{@staff.name} <#{@staff.email}>",
		     :subject => "HITCRS Registration Confirmation")   
	end
end 
