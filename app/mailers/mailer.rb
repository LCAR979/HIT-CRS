class Mailer < ActionMailer::Base   
	default from: "shuangchen1994@163.com"  
	def confirmation(applicant)     
		@applicant = applicant     
		mail(:to => "#{@applicant.name} <#{@applicant.email}>",
		     :subject => "HITCRS Registration Confirmation")   
	end
end 
