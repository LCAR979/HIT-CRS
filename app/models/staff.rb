class Staff < ActiveRecord::Base
	
	attr_accessible    :username, :password, :name, :phone, :email,
					:staffid, :status, :confirm_token, :tasks, :image
	# for saving images
	mount_uploader :image, ImageUploader
	before_save { |staff| staff.email = email.downcase }
  	before_create :confirmation_token

  
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