class RoomsController < ApplicationController
				  #may be it is a good option to set it to constants
	def index
		@search = Room.new
		@rooms = Room.all
		@roomsize = [42, 72, 120, 260]
		@Buildings = ['ZhengXin', 'GeWu']
		arr = Room.new.attributes.keys - Room.protected_attributes.to_a
		@attributes = arr[4..arr.length]
		respond_to do |format|
	      format.html		 # index.html.erb
	      format.json { render json: @rooms, json: @roomsize}
	  end
    end
    def show 
    	@roomsize = [42, 72, 120, 260]
		@Buildings = ['ZhengXin', 'GeWu']
    	@room = Room.find(params[:id])
	    respond_to do |format|
	      format.html 							# show.html.erb
	      format.json { render json: @room }
	    end
    end 
end
