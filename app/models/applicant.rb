class Applicant < ActiveRecord::Base
	before_create :confirmation_token
	attr_accessible :username, :studentid, :phone, :department, :email, :name, :password,:isvalid
	has_many :requests, dependent: :destroy
	#private

	def confirmation_token
		if self.confirmation_token.blank?
			self.confirmation_token = SecureRandom.urlsafe_base64.to_s
		end
	end

	def email_active
		self.email_confirmed = true
		self.confirm_token = nil
	end

end