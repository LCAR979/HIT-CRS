require 'digest'
class OverallControllController < ApplicationController
	def save
		if params[:identity] == "student"
			if Applicant.find_by_username(params[:username]) == nil
				hashpassword = secure_hash(params[:password])
				Applicant.create(username: params[:username], studentid: params[:studentid], phone: params[:phone], 
				department: params[:department],email: params[:email], name: params[:name], password: hashpassword, 
				isvalid:true)
				redirect_to '/login'
			else
				redirect_to '/signup', notice: 'username is already in use!'
			end
		elsif params[:identity] == "staff"
			if Staff.find_by_username(params[:username]) == nil
				hashpassword = secure_hash(params[:password])
				Staff.create(name: params[:name], username: params[:username], staffid: params[:staffid], phone: params[:phone],
				email: params[:email], password: hashpassword, isvalid:true)
				redirect_to("/login")
			else
				redirect_to '/signup', notice: 'username is already in use!'
			end
		else
			redirect_to("/signup")
		end
	end
	def check_login
		if params[:identity] == "student"
			hashpassword = secure_hash(params[:password])
			@searchRe = Applicant.find_by_username(params[:username])
			if @searchRe == nil || (hashpassword != @searchRe.password)
			#if hashpassword == @searchRe.password
				redirect_to("/login")
			elsif hashpassword == @searchRe.password
				redirect_to applicant_path(@searchRe)
			end
		elsif params[:identity] == "staff"
			hashpassword = secure_hash(params[:password])
			@searchRe = Staff.find_by_username(params[:username])
			if @searchRe == nil || (hashpassword != @searchRe.password)
			#	redirect_to("/home")
			# 	successful logging in staff to the certain staffs main pages
				redirect_to("/login")
			elsif hashpassword == @searchRe.password
				#redirect_to staff_requests_path(@searchRe)
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
