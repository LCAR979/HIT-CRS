class ApplicantsController < ApplicationController
	layout "basic"
    before_filter :signed_in_user, only: [ :setting, :history, 
    				:view_detail, :reset, :shut_down, :uploadimage ]
    before_filter :correct_user,   only: [ :setting, :history, 
    				:view_detail, :reset, :shut_down, :uploadimage]
	#applicant_path GET    /applicants/:id(.:format)            applicants#show
	#render applicants/show.html, applicant home page
	def show
		@applicant = Applicant.find(params[:id])
		respond_to do |format|
	    	format.html # show.html.erb
	    	format.json{ render json: @applicant}
	    end 	
	end

	#GET    /applicants/:id/setting(.:format)      applicants#setting
	#render applicants/setting.html                                               
	def setting
		@applicant = Applicant.find(params[:id])
		respond_to do |format|
			format.html{ render layout:"form"}
			format.json{ render json: @applicant}
		end
	end

	#GET    /applicants/:id/profile(.:format)      applicants#profile
	#render applicants/profile.html                                               
	def profile
		@applicant = Applicant.find(params[:id])
		respond_to do |format|
			format.html{ render layout:"form"}
			format.json{ render json: @applicant}
		end
	end

	#GET    /applicants/:id/histroy(.:format)        applicants#history
	#render applicants/history.html, history reservation page
	def history
		@applicant = Applicant.find(params[:id])
		@permitted_list=Request.find_all_by_status_and_applicant_id(0, @applicant.id,:order=>'week desc, day desc, time desc')
		@rejected_list=Request.find_all_by_status_and_applicant_id(1, @applicant.id,:order=>'week desc, day desc, time desc')
		@waiting_list=Request.find_all_by_status_and_applicant_id(2, @applicant.id,:order=>'week desc, day desc, time desc')
		@cancelled_list=Request.find_all_by_status_and_applicant_id(3, @applicant.id,:order=>'week desc, day desc, time desc')
		
		@waiting_list = @waiting_list.paginate(page: params[:page], per_page:3)
		@permitted_list = @permitted_list.paginate(page: params[:page], per_page:3)
		@rejected_list = @rejected_list.paginate(page: params[:page], per_page:3)
		@cancelled_list = @cancelled_list.paginate(page: params[:page], per_page:3)
		respond_to do |format|
	    	format.html 
	    	format.json{ render json: @waiting_list, json: @permitted_list,
	    						json: @rejected_list, json: @cancelled_list}
	    end  
	end

	#GET    /applicants/:applicant_id/requests/:id/show(.:format)  
	#render applicants/view_detail.html
	#view request details
	def view_detail
		@request = Request.find(params[:request_id])
		@applicant = Applicant.find(params[:applicant_id])
		respond_to do |format|
	    	format.html 
	    	format.json{ render json: @applicant}
	    end  
	end

	#POST   /applicants/:id/reset(.:format)         applicants#reset
	def reset
		@applicant = Applicant.find(params[:id])
		oldpassword = @applicant.password
		if oldpassword == secure_hash(params[:oldpassword])
			newpassword = secure_hash(params[:newpassword])
			@applicant.update_attributes(password:newpassword)
			flash[:success] = "Password modified successfully!"
			redirect_to applicant_path(@applicant)
		else 
			flash[:error] = "Old password is not correct!"
			redirect_to "/applicants/"+@applicant.id.to_s+"/setting/"
		end
	end

	#PUT    /applicants/:id/upload(.:format)        applicants#uploadimage
	def uploadimage
		@applicant = Applicant.find(params[:id])
		@applicant.update_attributes(params[:applicant])
		redirect_to applicant_path(@applicant)
	end

	# GET    /applicants/:id/shut_down(.:format)     applicants#shut_down
	def shut_down
		@applicant = Applicant.find(params[:id])
		@applicant.update_attributes('status'=>2)
		redirect_to '/index'
	end
	
	#confirm_email_applicant GET    /applicants/:id/confirm_email(.:format)       applicants#confirm_email
	def confirm_email  
		applicant = Applicant.find_by_confirm_token(params[:id])
		if applicant	    		      
			applicant.email_active
			applicant.save	 
			log_in applicant     
			flash[:success] = "Welcome to HIT-CRS! Your email has been confirmed" 	      
			redirect_to applicant_path(@applicant) 	    
		else 	      
			flash[:error] = "Sorry. User does not exist." 	      
			redirect_to '/signup' 	    
		end 	
	end
	
	# def requests_unread
	#   @messages = Messages.messages_received
	#   respond_to |format|
	#    format.json { render json: @messages }
	#   end
	# end  

	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end

	private
	def signed_in_user
		unless signed_in?
		  store_location
	      flash[:info] = "Please log in." 
	      redirect_to login_path
	    end
    end

    def correct_user
		if params[:id]
	  		@user = Applicant.find(params[:id])
	  	elsif params[:applicant_id]
	 		@user = Applicant.find(params[:applicant_id])
	 	end
	 	unless current_user?(@user)
	      	flash[:info] = "Please log in to continue."
	      	redirect_to login_path 
	    end
    end
end
