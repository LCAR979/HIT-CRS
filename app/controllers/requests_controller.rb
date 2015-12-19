class RequestsController < ApplicationController
	layout "basic"

	#call by staff only
	#show the request waiting to be processed belongs to certain staff
	def index    		
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
		@attributes = Request.new.attributes.keys - Request.protected_attributes.to_a
		@staff = Staff.find(params[:staff_id])
		@all_requests = Request.find_all_by_staff_id(params[:staff_id])
		respond_to do |format|
	    	format.html{ render layout:"basic"}
	    	format.json{ render json: @staff}
	    end 
	end


	#call by applicant 
	#go to new request page
	def new
	  @request = Request.new
	  @applicant = Applicant.find(params[:applicant_id])
      respond_to do |format|
	      format.html { render layout:"form"}# new.html.erb
	      format.json { render json: @request }
      end
  	end

  	#call by applicant
  	#try to create request object and save
  	def create
	    @request = Request.new(params[:request])
	    @request.applicant_id = params[:applicant_id]
	    @applicant = Applicant.find(params[:applicant_id])
	    @request.status = 2  	 #	request-status 0=>permited, 1=> rejected, 2=>wait 
	    @room = Room.find_by_building_and_location_and_week(@request.building, @request.location, @request.week)
	    str = 'day'+@request.day.to_s+'course' + @request.time.to_s	    
	    if @room != nil
	    	@room.update_attributes(str=>2)  #room-status 0=> 'free', 1=>'class', 2=>'wait', 3=>'reserved'
	    	@room.save
	    end

	    @staff = assignTasks()
	    @request.staff_id = @staff.id
	    @staff.tasks = @staff.tasks + 1
	    @staff.save

	    respond_to do |format|
	      if @request.save
	        format.html { redirect_to applicant_path(@applicant) , notice: 'request was successfully created.' }
	        format.json { render json: @request, status: :created, location: @request }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @request.errors, status: :unprocessable_entity }
	      end
	    end
  	end

  	#show the detail of the request
  	def show 
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
	    @request = Request.find(params[:id])
	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @request }
	    end 
  	end
  	
  	#find the staff has minimum number of tasks
  	def assignTasks
  		tasks_vals = Staff.all.map(&:tasks)
  		min_tasks = tasks_vals.min
  		staff_with_min_tasks = Staff.find_by_tasks(min_tasks)
  		return staff_with_min_tasks
  	end
end
