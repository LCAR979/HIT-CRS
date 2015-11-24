class StaffsController < ApplicationController
	#This controller is designed for teacher staff activities
	def index
		#list all the in processing request
		raise params.inspect
		@roomsize = [42, 72, 120, 260]
		@Buildings = ['ZhengXin', 'GeWu']
		@attributes = Request.new.attributes.keys - Request.protected_attributes.to_a
		#@rooms = Room.all  #put the room status testing to the index.html.erb
		#respond_to do |format|
	    #  format.html # index.html.erb
	    #  format.json { render json: @rooms }
	    #end
	    @requests = Request.all #put the room status testing to the index.html.erb
	    respond_to do |format|
	    	format.html # index.html.erb
	    	format.json{ render json: @requests }
	    end 
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
		@staff = Staff.find(params[:id])
		respond_to do |format|
	    	format.html # index.html.erb
	    	format.json{ render json: @staff }
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
