class Applicant < ActiveRecord::Base
	attr_accessible :username, :studentid, :phone, :department, :email, :name, :password,:isvalid
	has_many :requests, dependent: :destroy
end