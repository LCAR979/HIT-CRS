class RequestsController < ApplicationController
	layout "basic"
	def index 
		#show the inprocessing request belongs to certain staff
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
		@attributes = Request.new.attributes.keys - Request.protected_attributes.to_a
		@staff = Staff.find(params[:staff_id])
		@all_requests = Request.find_all_by_staff_id(params[:staff_id])
		respond_to do |format|
	    	format.html { render layout:"basic"}
	    	format.json{ render json: @staff}
	    end 
	end


	def new
	  @request = Request.new
	  #------------------------Added infor-----------
	  @applicant = Applicant.find(params[:applicant_id])
	  @room = Room.find(params[:room_id])
	  @day = params[:day].to_i
	  @course = params[:course].to_i
	  #-----------------------------------------------
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
	    @request.status = 3  			 
	    @room = Room.find_by_location_and_week(@request.location,@request.week)
	    str = 'day'+@request.day.to_s+'course' + @request.time.to_s
	    if @room != nil
	    	@room.update_attributes(str=>2)  #room status : wait
	    	@room.save
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
	    else
	    	redirect_to new_applicant_request_path(@applicant), notice: 'room does not exit!'
	    end

  	end

  	def show 
	#show the detail of the request
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
	    @request = Request.find(params[:id])
	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @request }
	    end 
  	end
  	
  	def assignTasks
  		tasks_vals = Staff.all.map(&:tasks)
  		min_tasks = tasks_vals.min
  		staff_with_min_tasks = Staff.find_by_tasks(min_tasks)
  		return staff_with_min_tasks
  	end
  	#cancel a request
  	def cancel
  		@applicant = Applicant.find(params[:applicant_id])
  		@request = Request.find(params[:id])
  		#change request status
  		@request.status = 4
  		#change room status
  		@room = Room.find_by_location_and_week(@request.location,@request.week)
	    str = 'day'+@request.day.to_s+'course' + @request.time.to_s
	    if @room != nil
	    	@room.update_attributes(str=>0)  #room status : free
	    	@room.save
	    end
	    @request.save
	    redirect_to "/applicants/"+@applicant.id.to_s+'/histroy/'
  	end
end

