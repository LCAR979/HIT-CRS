class RequestsController < ApplicationController
	def new
	  @request = Request.new
      respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @request }
      end
  	end
  	def create
	    @request = Request.new(params[:request])
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
end
