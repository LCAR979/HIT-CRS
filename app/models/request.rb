class Request < ActiveRecord::Base
	#set relationship with room
	attr_accessible  :week, :day, :time, :location, :building,
	:size, :media, :description, :status,
	:comment
	belongs_to :applicant
	belongs_to :staff

	def self.days
		 ['PlaceHolder','Monday', 'Tuesday','Wednesday',
		 	'Thursday','Friday','Saturday','Sunday']
	end

	def self.buildings
		['ZhengXin','Gewu']
	end

	def self.roomsize
		[42, 72, 120, 260]
	end

	def self.media
		['No','Yes']
	end
end
