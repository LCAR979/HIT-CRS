class StaffsController < ApplicationController
	layout "basic"
	before_filter :signed_in_user, only: [:setting, :index, 
    				:requestProc, :audit, :reset, :shut_down, :uploadimage ]
    before_filter :correct_user,   only:  [:setting, :index, 
    				:requestProc, :audit, :reset, :shut_down, :uploadimage]

    #staff_request 		GET /staffs/:staff_id/requests/:id(.:format)
    #render staff/show.html  show staff home page
	def show
		@staff= Staff.find(params[:id])
		respond_to do |format|
	    	format.html # show.html.erb
	    	format.json{ render json: @staff}
	    end 
	end

	#GET    /staffs/:id/setting(.:format)
    #render staff/setting.html   
	def setting
		@staff = Staff.find(params[:id])
		respond_to do |format|
			format.html{ render layout:"form"}
			format.json{ render json: @staff}
		end
	end

	#GET    /staffs/:id/profile(.:format)
    #render staff/profile.html   
	def profile
		@staff = Staff.find(params[:id])
		respond_to do |format|
			format.html{ render layout:"form"}
			format.json{ render json: @staff}
		end
	end

    #staff_requests_path
	#GET    /staffs/:staff_id/requests(.:format)
	#render staffs/index.html  -- requests to be processed
	def index	
    end

	# GET    /staffs/requestProc/:id(.:format)
	#render staffs/requestProc.html
	# goto specific request auditing page
	def requestProc
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
		@request = Request.find(params[:id])
		@staff = Staff.find(@request.staff_id)
		respond_to do |format|
	     	format.html{ render layout:"form"}
	     	format.json{ render json: @staff}
	   end 	
	end

    # PUT    /staffs/audit/:id(.:format)
    # save auditing request
	def audit
		@request = Request.find(params[:id])
		@request.comment = params[:request][:comment]
		@request.status = params[:request][:status]
		@request.save
		@room = Room.find_by_building_and_location_and_week(@request.building, @request.location,@request.week)
		str = 'day'+@request.day.to_s+'course' + @request.time.to_s	    
	    if @room != nil
	    	if @request.status == 0 			 #request permitted 0-> room reserved 3
	    		@room.update_attributes(str=>3)  #room status : reserved
	    	elsif @request.status == 1 			 #request rejected 1->room free 0
	    		@room.update_attributes(str=>0) 
	    	end
	    	@room.save
	    end
	    @applicant = Applicant.find_by_id(@request.applicant_id)
	    Mailer.inform_request_status(@applicant, @request).deliver
		@staff = Staff.find(@request.staff_id)
		redirect_to(staff_requests_path(@staff))
	end
	

	#POST   /staffs/:id/reset(.:format) 
	# 			from staff/modify.html
	def reset
		@staff = Staff.find(params[:id])
		oldpassword = @staff.password
		if oldpassword == secure_hash(params[:oldpassword])
			newpassword = secure_hash(params[:newpassword])
			@staff.update_attributes(password:newpassword)
			flash[:success] = "password modify successfully!"
			redirect_to staff_path(@staff)
		else 
			flash[:error] = "old password is not correct!"
			redirect_to "/staffs/"+@staff.id.to_s+"/setting/"
		end
	end

	def uploadimage
  		@staff = Staff.find(params[:id])		
		@staff.update_attributes(image:params[:staff][:image])
		redirect_to staff_path(@staff)
  	end
	
  	def uploadrooms
  		@staff = Staff.find(params[:id])
		respond_to do |format|
			format.html{ render layout:"form"}
			format.json{ render json: @staff}
		end
  	end
  	def import
	 	 #Staff.import(params[:file])
	 	 Staff.import(params[:staff][:file])
		 @staff = Staff.find(params[:id])
		 flash[:success] = "rooms status imported."
		 redirect_to staff_path(@staff)
	end 
	# confirm_email_staff GET    
	#/staffs/:id/confirm_email(.:format) 
	def confirm_email     	
		staff = Staff.find_by_confirm_token(params[:id])
		if staff	    		      
			staff.email_active	
			staff.save   
			log_in staff   
			flash[:success] = "Welcome to HIT-CRS! Your email has been confirmed." 	      
			redirect_to staff_path(staff)	    
		else 	      
			flash[:error] = "Sorry. User does not exist." 	      
			redirect_to '/signup' 	    
		end 	
	end

	def shut_down
		@staff = Staff.find(params[:id])
		@staff.update_attributes('status'=>2)
		redirect_to '/index'
	end

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
      @user = Staff.find(params[:id])
      flash[:info] = "Please log in to continue."
      redirect_to login_path unless current_user?(@user)
    end

end
