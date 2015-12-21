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
	# POST   /applicants/:id/setting(.:format) 
	#render applicants/setting.html                                               
	def setting
		@applicant = Applicant.find(params[:id])
		respond_to do |format|
			format.html{ render layout:"form"}
			format.json{ render json: @applicant}
		end
	end

	# GET    /applicants/:id/reset(.:format)  
	def reset
		@applicant = Applicant.find(params[:id])
		oldpassword = @applicant.password
		if oldpassword == secure_hash(params[:oldpassword])
			newpassword = secure_hash(params[:newpassword])
			@applicant.update_attributes(password:newpassword)
			flash[:success] = "password modify successfully!"
			redirect_to applicant_path(@applicant)
		else 
			flash[:error] = "old password is not correct!"
			redirect_to "/applicants/"+@applicant.id.to_s+"/modify/"
		end
	end
	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end

	#GET    /applicants/:id/histroy(.:format) 
	#render applicants/history.html
	def history
		@applicant = Applicant.find(params[:id])
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
		respond_to do |format|
	    	format.html 
	    	format.json{ render json: @applicant}
	    end  
	end

	#GET    /applicants/:applicant_id/requests/:id/show(.:format)  
	#render applicants/view_detail.html
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

	#confirm_email_applicant 
	#GET    /applicants/:id/confirm_email(.:format)
	def confirm_email  
		applicant = Applicant.find_by_confirm_token(params[:id])
		if applicant	    		      
			applicant.email_active
			applicant.save	      
			flash[:success] = "Welcome to HIT-CRS! Your email has been confirmed.Please sign in to continue." 	      
			redirect_to '/login' 	    
		else 	      
			flash[:error] = "Sorry. User does not exist." 	      
			redirect_to '/signup' 	    
		end 	
	end
	def uploadimage
		@applicant = Applicant.find(params[:id])
		@applicant.update_attributes(params[:applicant])
		redirect_to applicant_path(@applicant)
	end

	def shut_down
		@applicant = Applicant.find(params[:id])
		@applicant.update_attributes('status'=>2)
		redirect_to '/index'
	end

end
