class RequestsController < ApplicationController
	layout "basic"

	#staff_requests GET    /staffs/:staff_id/requests(.:format) 
	#call by staff only
	#show the request waiting to be processed belongs to certain staff
	def index    		
		@attributes = Request.new.attributes.keys - Request.protected_attributes.to_a
		@staff = Staff.find(params[:staff_id])
		@all_requests = Request.find_all_by_staff_id(params[:staff_id])
		respond_to do |format|
	    	format.html
	    	format.json{ render json: @staff}
	    end 
	end


	#new_applicant_request 
	#GET    /applicants/:applicant_id/requests/new(.:format) 
	#call by applicant 
	#go to new request page
	def new
	  @request = Request.new
	  @applicant = Applicant.find(params[:applicant_id])
	  @room = Room.find(params[:room_id])
	  @day = params[:day].to_i
	  @course = params[:course].to_i
      respond_to do |format|
	      format.html { render layout:"form"}# new.html.erb
	      format.json { render json: @request }
      end
  	end

  	#POST   /applicants/:applicant_id/requests(.:format)   
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
		    @staff = assignTasks()
		    @request.staff_id = @staff.id
		    @staff.tasks = @staff.tasks + 1
		    @staff.save
		end 
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
  	#cancel a request
  	def cancel
  		@applicant = Applicant.find(params[:applicant_id])
  		@request = Request.find(params[:request_id])
  		#change request status
  		@request.status = 4
  		#change room status
  		@room = Room.find_by_building_and_location_and_week(@request.building,@request.location,@request.week)
	    str = 'day'+@request.day.to_s+'course' + @request.time.to_s
	    if @room != nil
	    	@room.update_attributes(str=>0)  #room status : free
	    	# cancel num + 1
	    	@applicant.cancel_num = @applicant.cancel_num + 1
	    	@applicant.save
	    	if @applicant.cancel_num == 4
	    		# do some thing
	    	end
	    	#@room.save
	    end
	    @request.save
	    redirect_to "/applicants/"+@applicant.id.to_s+'/histroy/'
  	end
end
