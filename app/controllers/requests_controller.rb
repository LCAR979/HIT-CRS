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
	#layout "basic"
	def new
	  @request = Request.new
	  @applicant = Applicant.find(params[:applicant_id])
	  #raise params
      respond_to do |format|
	      format.html { render layout:"form"}# new.html.erb
	      format.json { render json: @request }
	      
      end
  	end
  	def create
	    @request = Request.new(params[:request])
	    @request.applicant_id = params[:applicant_id]
	    @applicant = Applicant.find(params[:applicant_id])
	    @request.status = 3  			 #initial status: processing
	    #Request assignment Currently assign to first staff
	    #Equal Principle
	    @room = Room.find_by_location_and_week(@request.location,@request.week)
	    str = 'day'+@request.day.to_s+'course' + @request.time.to_s
	    if @room != nil
	    	@room.attributes[str] = 2
	    	@room.save
	    end
	    @staff = assignTasks()
	    @request.staff_id = @staff.id
	    @staff.tasks = @staff.tasks + 1
	    @staff.save
	    #raise @request.staff_id
	    #---------------------------------------------------
	    #@request.staff_id = Staff.first.id
	    #---------------------------------------------------
	    respond_to do |format|
	      if @request.save
	        format.html { redirect_to applicant_path(@applicant) , notice: 'Request was successfully created.' }
	    @request.status = 3  			 #initial status: processing
	    respond_to do |format|
	      if @request.save
	        format.html { redirect_to "/rooms" , notice: 'request was successfully created.' }
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
  		tasks_vals = Staff.all.map(&:tasks)
  		min_tasks = tasks_vals.min
  		staff_with_min_tasks = Staff.find_by_tasks(min_tasks)
  		return staff_with_min_tasks
  	end
end
