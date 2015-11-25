class RequestsController < ApplicationController
	def index 
		#show the inprocessing request belongs to certain staff
		@roomsize = [42, 72, 120, 260]
		@Buildings = ['ZhengXin', 'GeWu']
		@attributes = Request.new.attributes.keys - Request.protected_attributes.to_a
		@staff = Staff.find(params[:staff_id])
		@myrequests = Request.find_all_by_staff_id(params[:staff_id])
		respond_to do |format|
	    	format.html # index.html.erb
	    	format.json{ render json: @staff}
	    end 
	end
	def new
	  @request = Request.new
	  @applicant = Applicant.find(params[:applicant_id])
	  #raise params
      respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @request}
      end
  	end
  	def create
	    @request = Request.new(params[:request])
	    @request.applicant_id = params[:applicant_id]
	    @applicant = Request.find(params[:applicant_id])
	    @request.status = 3  			 #initial status: processing
	    #Request assignment Currently assign to first staff
	    #---------------------------------------------------
	    @request.staff_id = Staff.first.id
	    #---------------------------------------------------
	    respond_to do |format|
	      if @request.save
	        format.html { redirect_to applicant_path(@applicant) , notice: 'Request was successfully created.' }
	        format.json { render json: @request, status: :created, location: @request }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @request.errors, status: :unprocessable_entity }
	      end
	    end
  	end
  	def show 
	#show the detail of the request
		@roomsize = [42, 72, 120, 260]
		@Buildings = ['ZhengXin', 'GeWu']
	    @request = Request.find(params[:id])
	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @request }
	    end 
  	end
  	def assignTasks()
  		requests = Request.all
  		
  	end
end
