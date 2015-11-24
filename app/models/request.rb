class Request < ActiveRecord::Base
	#set relationship with room
	attr_accessible :name,:department, :location,:studentid, :phone, :description, :numAttendents, :building ,:size, :media, :week, :time, :status, :comment, :teachername, :teacherphone
end