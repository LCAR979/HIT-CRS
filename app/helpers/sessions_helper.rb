module SessionsHelper
	def signed_in?
	    !current_user.nil?
	end
	
	def log_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
		if Applicant.find_by_remember_token(user.remember_token)
    		self.current_group = "Applicant"
    	elsif Staff.find_by_remember_token(user.remember_token)
    		self.current_group = "Staff"
    	end
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= Applicant.find_by_remember_token(cookies[:remember_token])
		@current_user ||= Staff.find_by_remember_token(cookies[:remember_token])	    
	end

	def current_group=(s)
	    @current_group = s 
	end

	def current_group
	  if @current_group != nil
	  	@current_group
	  elsif Applicant.find_by_remember_token(cookies[:remember_token]) != nil
		"Applicant"
	  elsif Staff.find_by_remember_token(cookies[:remember_token])!=nil
	  	"Staff"
	  else
	  	"Guest"
	  end
	end

	def log_out
		self.current_user = nil
    	cookies.delete(:remember_token)
	end
end
