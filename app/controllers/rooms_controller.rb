class RoomsController < ApplicationController
	layout "basic"

	#rooms_path
	#GET    /rooms(.:format)
	def index
		@search = Room.new
		@rooms = Room.all
		arr = Room.new.attributes.keys - Room.protected_attributes.to_a
		@attributes = arr[4..arr.length]
		if params[:applicant_id]
			@applicant = Applicant.find(params[:applicant_id])
		elsif params[:staff_id]
			@staff = Staff.find(params[:staff_id])
		end
		respond_to do |format|
	      format.html		 # index.html.erb
	      format.json { render json: @rooms, json:@search}
	  	end
    end

  #   #GET    /rooms/staff/:staff_id(.:format) 
  #   def staff_room
		# @search = Room.new
		# @rooms = Room.all
		# arr = Room.new.attributes.keys - Room.protected_attributes.to_a
		# @attributes = arr[4..arr.length]
		# @staff = Staff.find(params[:staff_id])
		# respond_to do |format|
	 #      format.html		 # index.html.erb
	 #      format.json { render json: @rooms, json: @roomsize}
	 #  	end
  #   end

    def search
    	@search = Room.new
		@rooms = Room.all
		arr = Room.new.attributes.keys - Room.protected_attributes.to_a
		@attributes = arr[4..arr.length]
    	@room = Room.find_by_week_and_building_and_location(params[:room][:week], params[:room][:building], params[:room][:location])
		respond_to do |format|
	      format.html		 # index.html.erb
	      format.json { render json: @rooms, json: @roomsize, json:@search}
	  	end
    end
end
