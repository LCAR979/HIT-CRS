require 'digest'
class OverallControllController < ApplicationController
	def save
		if params[:work] == "student"
			hashpassword = secure_hash(params[:password])
			Applicant.create(username: params[:username], studentid: params[:studentid], phone: params[:phone], 
			department: params[:department],email: params[:email], name: params[:name], password: hashpassword, 
			isvalid:true)
			redirect_to('/')
		elsif params[:work] == "staff"
			hashpassword = secure_hash(params[:password])
			Staff.create(name: params[:name], username: params[:username], staffid: params[:staffid], phone: params[:phone],
			email: params[:email], password: hashpassword, isvalid:true)
			redirect_to("/")
		else
			redirect_to("/signup")
		end
	end
	def check_login
		if params[:work] == "student"
			hashpassword = secure_hash(params[:password])
			searchRe = Applicant.find_by_username(params[:username])
			if hashpassword == searchRe.password
				redirect_to("/home")
			else
				redirect_to("/login")
			end
		elsif params[:work] == "staff"
			hashpassword = secure_hash(params[:password])[0]
			searchRe = Staff.find_by_username(params[:username])
			if hashpassword == searchRe.password
				redirect_to("/home")
			else
				redirect_to("/login")
			end
		else
			redirect_to("/login")
		end 
	end
	
	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end
end