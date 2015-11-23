class Request < ActiveRecord::Base
	attr_accessible :name,:department, :location,:studentid, :phone, :description, :numAttendents, :building ,:size, :media, :week, :time, :allow, :comment, :teachername, :teacherphone
end