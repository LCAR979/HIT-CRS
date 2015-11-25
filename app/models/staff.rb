class Staff < ActiveRecord::Base
	attr_accessible :name, :staffid, :phone, :email, :username, :password,:isvalid, :tasks
end