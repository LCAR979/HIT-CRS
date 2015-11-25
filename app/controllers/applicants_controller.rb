class ApplicantsController < ApplicationController
	layout "basic"
	def show
		@applicant = Applicant.find(params[:id])
		respond_to do |format|
	    	format.html # show.html.erb
	    	format.json{ render json: @applicant}
	    end 	
	end
end
