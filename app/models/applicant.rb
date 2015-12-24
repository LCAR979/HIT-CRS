class Applicant < ActiveRecord::Base
	
	attr_accessible :username, :password,  :name, :phone,  :email, 
	:studentid,  :department, :status, :confirm_token, :cancel_num,:image, :unread, :remember_token
	has_many :requests, dependent: :destroy
	# for saving images
	mount_uploader :image, ImageUploader
	before_save { |applicant| applicant.email = email.downcase }
 	before_create :confirmation_token

  
	def confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end
	end

	def email_active
		self.status = 1
		#self.confirm_token = nil
	end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64.to_s
    end
end