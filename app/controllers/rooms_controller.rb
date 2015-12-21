class RoomsController < ApplicationController
	layout "basic"

	#rooms 
	#GET    /rooms(.:format)
	def index
		@search = Room.new
		@rooms = Room.all
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
		arr = Room.new.attributes.keys - Room.protected_attributes.to_a
		@attributes = arr[4..arr.length]
		if params[:applicant_id]
			@applicant = Applicant.find(params[:applicant_id])
		end
		if params[:staff_id]
			@staff = Staff.find(params[:staff_id])
		end
		respond_to do |format|
	      format.html		 # index.html.erb
	      format.json { render json: @rooms, json: @roomsize}
	  	end
    end

    #GET    /rooms/staff/:staff_id(.:format) 
    def staff_room
		@search = Room.new
		@rooms = Room.all
		@roomsize = [42, 72, 120, 260]
		@buildings = ['ZhengXin', 'GeWu']
		arr = Room.new.attributes.keys - Room.protected_attributes.to_a
		@attributes = arr[4..arr.length]
		@staff = Staff.find(params[:staff_id])
		respond_to do |format|
	      format.html		 # index.html.erb
	      format.json { render json: @rooms, json: @roomsize}
	  	end
    end
end
