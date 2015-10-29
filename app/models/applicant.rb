class Applicant < ActiveRecord::Base
	attr_accessible :username, :studentid, :phone, :department, :email, :name, :password,:isvalid
end