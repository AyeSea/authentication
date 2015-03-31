class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :save_token


	validates :username, presence: true, uniqueness: true, length: { in: 5..20 }
	validates :email, presence: true, uniqueness: { case_sensitive: false },
										length: { in: 5..30 }

	has_secure_password
	validates :password, length: { in: 8..30 }
	
	def save_token(token)
		self.remember_token = User.digest(token)
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token)
	end

	def User.create_token
		SecureRandom.urlsafe_base64
	end
end