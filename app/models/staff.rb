class Staff < ActiveRecord::Base
	require 'csv'
	before_create :confirmation_token
	attr_accessible    :username, :password, :name, :phone, :email,
					:staffid, :status, :confirm_token, :tasks, :image, :unread,:remember_token
	# for saving images
	mount_uploader :image, ImageUploader
	before_save { |staff| staff.email = email.downcase }
  	before_create :confirmation_token

	def self.import(file)
		i = 1
		building = {"ZhengXin"=>0, "GeWe"=>1}
		newrecordhash = Hash.new
		#week2num = {"Mon"=>1, "Tue"=>2, "Wed"=>3, "Thu"=>4, "Fri"=>5, "Sat"=>6, "Sun"=>7}
		CSV.foreach(file.path, headers:true) do |row|
			if (i!=1)
				recordhash = row.to_hash
				#puts recordhash
				recordhash.each do |key, value|
					case key
					when "building"
						newrecordhash[key] = building[value]
					when /Mon(\d{1,2})/
						newrecordhash['day1'+'course'+$1.to_s] = value
					when /Tue(\d{1,2})/
						newrecordhash['day2'+'course'+$1.to_s] = value
					when /Wed(\d{1,2})/
						newrecordhash['day3'+'course'+$1.to_s] = value
					when /Thu(\d{1,2})/
						newrecordhash['day4'+'course'+$1.to_s] = value
					when /Fri(\d{1,2})/
						newrecordhash['day5'+'course'+$1.to_s] = value
					when /Sat(\d{1,2})/
						newrecordhash['day6'+'course'+$1.to_s] = value
					when /Sun(\d{1,2})/
						newrecordhash['day7'+'course'+$1.to_s] = value
					when "week"
						newrecordhash[key] = value
					when "location"
						newrecordhash[key] = value
					end
				end
			end
			i = i+1
		end
		Room.create! newrecordhash
		#Room.create! row.to_hash
	end
  
	def confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end
	end

	def email_active
		self.status = 1
		self.confirm_token = nil
	end


    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end