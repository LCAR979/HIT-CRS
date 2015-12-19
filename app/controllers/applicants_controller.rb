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
		applicant = Applicant.find_by_confirm_token(params[:confirm_token])
		if applicant 	    		      
			applicant.email_activate 	      
			flash[:success] = "Welcome to HIT-CRS! Your email has been confirmed. 	      Please sign in to continue." 	      
			redirect_to '/login' 	    
		else 	      
			flash[:error] = "Sorry. User does not exist." 	      
			redirect_to '/signup' 	    
		end 	
	end

end
