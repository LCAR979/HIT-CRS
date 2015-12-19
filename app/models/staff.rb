class Staff < ActiveRecord::Base
	attr_accessible    :username, :password, :name, :phone, :email,
					:staffid, :status, :confirm_token, :tasks
end