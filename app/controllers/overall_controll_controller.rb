require 'digest'
class OverallControllController < ApplicationController
	def save
		if params[:identity] == "student"
			if Applicant.find_by_email(params[:email]) == nil
				hashpassword = secure_hash(params[:password])
				@applicant = Applicant.new(username: params[:username], studentid: params[:studentid], 
					phone: params[:phone], department: params[:department],
					email: params[:email], name: params[:name], password: hashpassword, 
					status:0)
				if @applicant.save
					Mailer.applicant_confirmation(@applicant).deliver
					flash[:success] = "Please confirm your email to continue"
					redirect_to '/login'
				else
					flash[:error] = "Ooooppss, something went wrong"
					redirect_to '/signup'
				end
			else
				flash[:error] = "Email address is already taken!"
				redirect_to '/signup'
			end
		elsif params[:identity] == "staff"
			if Staff.find_by_email(params[:email]) == nil
				hashpassword = secure_hash(params[:password])
				@staff  = Staff.new(name: params[:name], username: params[:username], staffid: params[:staffid],
				 phone: params[:phone], email: params[:email], password: hashpassword, status:0)
				if @staff.save
					Mailer.staff_confirmation(@staff).deliver
					flash[:success] = "Please confirm your email to continue"
					redirect_to '/login'
				else
					flash[:error] = "Ooooppss, something went wrong"
					redirect_to '/signup'
				end
			else
				flash[:error] = "Email address is already taken!"
				redirect_to '/signup'
			end
		else
			redirect_to "/signup"
		end
	end


	def check_login
		if params[:identity] == "student"
			hashpassword = secure_hash(params[:password])
			@searchRe = Applicant.find_by_email(params[:email])
			if @searchRe == nil
				flash[:error] = "User does not exist"
				redirect_to("/login")
			elsif @searchRe.status == 0
				flash[:error] = "Account has not been activated"
				redirect_to("/login")
			elsif @searchRe.status == 2
				flash[:error] = "Account has been shut down"
				redirect_to("/login")
			elsif hashpassword != @searchRe.password
				flash[:error] = "Wrong password"
				redirect_to("/login")
			elsif hashpassword == @searchRe.password
				flash[:success] = "Welcome"
				cookies[:username] = Applicant.find_by_username(@searchRe.username)
				redirect_to applicant_path(@searchRe)
			end
		elsif params[:identity] == "staff"
			hashpassword = secure_hash(params[:password])
			@searchRe = Staff.find_by_email(params[:email])
			if @searchRe == nil
				flash[:error] = "User does not exist"
				redirect_to("/login")
			elsif @searchRe.status == 0
				flash[:error] = "Account has not been activated"
				redirect_to("/login")
			elsif @searchRe.status == 2
				flash[:error] = "Account has been shut down"
				redirect_to("/login")
			elsif hashpassword != @searchRe.password
				flash[:error] = "Wrong password"
				redirect_to("/login")
			elsif hashpassword == @searchRe.password
				flash[:success] = "Welcome"
				cookies[:username] = Staff.find_by_username(@searchRe.username)
				redirect_to applicant_path(@searchRe)
			end
		else
			redirect_to("/login")
		end 
	end
	
	def logout
		redirect_to("/index")
	end

	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end
end
