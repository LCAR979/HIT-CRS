class Applicant < ActiveRecord::Base
	before_create :confirmation_token
	attr_accessible :username, :password,  :name, :phone,  :email, :studentid,  :department, :status, :confirm_token
	has_many :requests, dependent: :destroy

	def confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end
	end

	def email_active
		self.status = 1
		self.confirm_token = nil
	end

end