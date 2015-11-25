class StaffsController < ApplicationController
	layout "basic"
	#This controller is designed for teacher staff activities
	def requestProc
		@roomsize = [42, 72, 120, 260]
		@Buildings = ['ZhengXin', 'GeWu']
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
		@room = Room.find_by_location(request.location)
	    if @room != nil
	    	#request status: 1=>permited 2=> rejected 3=>processing
	    	#room request 0=> 'available', 1=>'in use', 2=>'processing'
	    	if @request.status == 1
	    		@room.status = 1
	    	elsif @request.status == 2
	    		@room.status = 0
	    	end
	    end
		@staff = Staff.find(@request.staff_id)
		redirect_to(staff_requests_path(@staff))
	end
	
	def index	
    end
	def show
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
