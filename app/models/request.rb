class Request < ActiveRecord::Base
	#set relationship with room
	attr_accessible  :week, :day, :time, :location, :building,
	:size, :media, :description, :status,
	:comment
	belongs_to :applicant
	belongs_to :staff
end
