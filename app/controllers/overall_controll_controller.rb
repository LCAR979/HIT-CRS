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
					Mailer.confirmation(@applicant).deliver
					flash[:success] = "Please confirm your email to continue"
					redirect_to '/login'
				else
					falsh[:error] = "Ooooppss, something went wrong"
					redirect_to '/signup'
				end
			else
				redirect_to '/signup', notice: 'Email is already taken!'
			end
		elsif params[:identity] == "staff"
			if Staff.find_by_email(params[:email]) == nil
				hashpassword = secure_hash(params[:password])
				@staff  = Staff.new(name: params[:name], username: params[:username], staffid: params[:staffid],
				 phone: params[:phone], email: params[:email], password: hashpassword, status:0)
				if @staff.save
					Mailer.confirmation(@staff).deliver
					flash[:success] = "Please confirm your email to continue"
					redirect_to '/login'
				else
					falsh[:error] = "Ooooppss, something went wrong"
					redirect_to '/signup'
				end
			else
				redirect_to '/signup', notice: 'Email is already taken!'
			end
		else
			redirect_to("/signup")
		end
	end


	def check_login
		if params[:identity] == "student"
			hashpassword = secure_hash(params[:password])
			@searchRe = Applicant.find_by_email(params[:email])
			if @searchRe == nil || (hashpassword != @searchRe.password)
				redirect_to("/login")
			elsif hashpassword == @searchRe.password
				redirect_to applicant_path(@searchRe)
			end
		elsif params[:identity] == "staff"
			hashpassword = secure_hash(params[:password])
			@searchRe = Staff.find_by_email(params[:email])
			if @searchRe == nil || (hashpassword != @searchRe.password)
				redirect_to("/login")
			elsif hashpassword == @searchRe.password
				redirect_to staff_path(@searchRe)
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
