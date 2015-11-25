class StaffsController < ApplicationController
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
		@staff = Staff.find(@request.staff_id)
		redirect_to(staff_requests_path(@staff))
	end
	def index
		# @roomsize = [42, 72, 120, 260]
		# @Buildings = ['ZhengXin', 'GeWu']
		# @attributes = Request.new.attributes.keys - Request.protected_attributes.to_a
		# @staff = Staff.find(params[:id])
		# @myrequests = Request.find_all_by_staff_id(params[:id])
		# respond_to do |format|
	 #    	format.html # index.html.erb
	 #    	format.json{ render json: @staff}
	 #    end 	
		#---------------------------------------------------------
		#list all the in processing request
		# raise params.inspect
		# @roomsize = [42, 72, 120, 260]
		# @Buildings = ['ZhengXin', 'GeWu']
		# @attributes = Request.new.attributes.keys - Request.protected_attributes.to_a
	 #    @requests = Request.all #put the room status testing to the index.html.erb
	 #    respond_to do |format|
	 #    	format.html # index.html.erb
	 #    	format.json{ render json: @requests }
	 #    end 
	    #-------------------------------------------------------
    end
    # def auditrequest
    # 	@request = Request.find(params[:id])
    # 	respond_to do |format|
	   #    format.html # show.html.erb
	   #    format.json { render json: @request }
	   #  end
    # end
    # def approveOrnot
    # 	@request = Request.find(params[:id])
    # 	@request = 
    # 	#tag => checkbox name
    # 	if (params[tag] == 0)   #approved
    # 		@request.comment = params[:comment]
    # 		@request.auditStaffname = 
    # 	elsif (params[tag] == 1) #regected

    # 	end	
    # end
	def show
		#changed !
		# @roomsize = [42, 72, 120, 260]
		# @Buildings = ['ZhengXin', 'GeWu']
		# @attributes = Request.new.attributes.keys - Request.protected_attributes.to_a
		# @staff = Staff.find(params[:id])
		# @myrequests = Request.find_all_by_staff_id(params[:id])
		# respond_to do |format|
	 #    	format.html # index.html.erb
	 #    	format.json{ render json: @staff}
	 #    end 	
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
