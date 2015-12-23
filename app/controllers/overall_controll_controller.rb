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
					@applicant.create_remember_token
					@applicant.save
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
				if params[:invitation_code] == secure_hash(params[:username])[0,8]
					hashpassword = secure_hash(params[:password])
					@staff  = Staff.new(name: params[:name], username: params[:username], staffid: params[:staffid],
					 phone: params[:phone], email: params[:email], password: hashpassword, status:0)
					if @staff.save
						Mailer.staff_confirmation(@staff).deliver
						@staff.create_remember_token
						@staff.save
						flash[:success] = "Please confirm your email to continue"
						redirect_to '/login'
					else
						flash[:error] = "Ooooppss, something went wrong"
						redirect_to '/signup'
					end
				else 
					flash[:error] = "invitation_code is not valid, please contact Administrators"
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

	def secure_hash(string)
		return Digest::SHA2.hexdigest(string)
	end
end
