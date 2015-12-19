class ApplicantsController < ApplicationController
	layout "basic"
	def show
		@applicant = Applicant.find(params[:id])
		respond_to do |format|
	    	format.html # show.html.erb
	    	format.json{ render json: @applicant}
	    end 	
	end
	def confirm_email     	
		applicant = Applicant.find_by_confirm_token(params[:id])
		if applicant 	    	
			#What is email_activate? 	      
			applicant.email_activate 	      
			flash[:success] = "Welcome to the Sample App! Your email has been confirmed. 	      Please sign in to continue." 	      
			redirect_to '/login' 	    
		else 	      
			flash[:error] = "Sorry. User does not exist" 	      
			redirect_to '/signup' 	    
		end 	
	end

end
