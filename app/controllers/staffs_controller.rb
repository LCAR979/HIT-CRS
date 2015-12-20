class StaffsController < ApplicationController
	layout "basic"
	#This controller is designed for teacher staff activities
	def requestProc
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
		@request = Request.find(params[:id])
		@staff = Staff.find(@request.staff_id)
		respond_to do |format|
	     	format.html # index.html.erb
	     	format.json{ render json: @staff}
	   end 	
	end
	def audit
		@request = Request.find(params[:id])
		@request.comment = params[:request][:comment]
		@request.status = params[:request][:status]
		@request.save
		@room = Room.find_by_location_and_week(@request.location,@request.week)
		str = 'day'+@request.day.to_s+'course' + @request.time.to_s
	    
	    if @room != nil
	    	if @request.status == 1
	    		@room.update_attributes(str=>3)  #room status : wait
	    	elsif @request.status == 2
	    		@room.update_attributes(str=>0)
	    	end
	    	@room.save
	    end


		@staff = Staff.find(@request.staff_id)
		redirect_to(staff_requests_path(@staff))
	end
	
	def index	
    end

	def show
		@staff= Staff.find(params[:id])
		respond_to do |format|
	    	format.html # show.html.erb
	    	format.json{ render json: @staff}
	    end 
	end
	#--------------------------For reset password----------------------------
	def modify
		@staff = Staff.find(params[:id])
		respond_to do |format|
			format.html
			format.json{ render json: @staff}
		end
	end
	def reset
		@staff = Staff.find(params[:id])
		oldpassword = @staff.password
		if oldpassword == secure_hash(params[:oldpassword])
			newpassword = secure_hash(params[:newpassword])
			@staff.update_attributes(password:newpassword)
			redirect_to staff_path(@staff), notice: 'password modify successfully!'
		else 
			redirect_to "/staffs/"+@staff.id.to_s+"/modify/", notice: 'old password is not correct!'
		end
	end
	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end
	#-------------------------------------------------------------------------------
	def confirm_email     	
		staff = Staff.find_by_confirm_token(params[:confirm_token])
		if staff	    		      
			staff.email_activate 	      
			flash[:notice] = "Welcome to HIT-CRS! Your email has been confirmed.Please sign in to continue." 	      
			redirect_to '/login' 	    
		else 	      
			flash[:notice] = "Sorry. User does not exist." 	      
			redirect_to '/signup' 	    
		end 	
	end

	def new	
	end
	def create
	end
	def update 
	end
	def destroy
	end
	def edit 
	end

end
