class SessionsController < ApplicationController
	layout "basic"
    #new_session_path
    #login	/login(.:format) 
    #GET    /sessions/new(.:format)        				sessions#new
	def new
		respond_to do |format|
	     	format.html{ render layout:"form"}
	     	format.json
	   end 	
	end


	#sessions_path
	#POST   /sessions(.:format)               sessions#create
	def create
		if params[:session][:identity] == "student"
			hashpassword = secure_hash(params[:session][:password])
			@searchRe = Applicant.find_by_email(params[:session][:email].downcase)

			if @searchRe == nil
				flash[:error] = "User does not exist"
				redirect_to login_path
			elsif @searchRe.status == 0
				flash[:error] = "Account has not been activated"
				redirect_to login_path
			elsif @searchRe.status == 2
				flash[:error] = "Account has been shut down"
				redirect_to login_path
			elsif hashpassword != @searchRe.password
				flash[:error] = "Wrong password"
				redirect_to login_path
			elsif hashpassword == @searchRe.password
				flash[:success] = "Welcome"
				log_in @searchRe
				redirect_to applicant_path(@searchRe)
			end
		elsif params[:session][:identity] == "staff"
			hashpassword = secure_hash(params[:session][:password])
			@searchRe = Staff.find_by_email(params[:session][:email].downcase)
			if @searchRe == nil
				flash[:error] = "User does not exist"
				redirect_to login_path
			elsif @searchRe.status == 0
				flash[:error] = "Account has not been activated"
				redirect_to login_path
			elsif @searchRe.status == 2
				flash[:error] = "Account has been shut down"
				redirect_to login_path
			elsif hashpassword != @searchRe.password
				flash[:error] = "Wrong password"
				redirect_to login_path
			elsif hashpassword == @searchRe.password
				flash[:success] = "Welcome"
				log_in @searchRe
				redirect_to staff_path(@searchRe)
			end
		else
			redirect_to login_path
		end 
	end

	#session_path
	#logout DELETE /logout(.:format)                    sessions#destroy
	#DELETE /sessions/:id(.:format)            sessions#destroy
	def destroy
		log_out
		redirect_to root_path
	end

	def secure_hash(string)
		return Digest::SHA2.hexdigest(string)
	end
end
