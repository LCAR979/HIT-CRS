class ApplicantsController < ApplicationController
	layout "basic"
	def show
		@applicant = Applicant.find(params[:id])
		respond_to do |format|
	    	format.html # show.html.erb
	    	format.json{ render json: @applicant}
	    end 	
	end

	#------------------------For reset password-----------------------
	def modify
		@applicant = Applicant.find(params[:id])
		respond_to do |format|
			format.html
			format.json{ render json: @applicant}
		end
	end
	def reset
		@applicant = Applicant.find(params[:id])
		oldpassword = @applicant.password
		if oldpassword == secure_hash(params[:oldpassword])
			newpassword = secure_hash(params[:newpassword])
			@applicant.update_attributes(password:newpassword)
			redirect_to applicant_path(@applicant), notice: 'Password modify successfully!'
		else 
			redirect_to "/applicants/"+@applicant.id.to_s+"/modify/", notice: 'Wrong password'
		end
	end
	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end

	#----------------------------------------------------------------------
	def history
		@applicant = Applicant.find(params[:id])
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
		respond_to do |format|
	    	format.html # show.html.erb
	    	format.json{ render json: @applicant}
	    end  
	end

	#view request details
	def view_detail
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
		@request = Request.find(params[:id])
		@applicant = Applicant.find(params[:applicant_id])
		respond_to do |format|
	    	format.html # show.html.erb
	    	format.json{ render json: @applicant}
	    end  
	end

	def confirm_email  
		applicant = Applicant.find_by_confirm_token(params[:id])
		if applicant	    		      
			applicant.email_active	      
			flash[:success] = "Welcome to HIT-CRS! Your email has been confirmed.Please sign in to continue." 	      
			redirect_to '/login' 	    
		else 	      
			flash[:error] = "Sorry. User does not exist." 	      
			redirect_to '/signup' 	    
		end 	
	end

end
