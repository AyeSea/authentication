class User < ActiveRecord::Base
	attr_accessor :remember_token
	
	before_save { self.email = email.downcase }
	before_create :save_token


	validates :username, presence: true, uniqueness: true, length: { in: 5..20 }
	validates :email, presence: true, uniqueness: { case_sensitive: false },
										length: { in: 5..30 }

	has_secure_password
	validates :password, length: { in: 8..30 }

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	private
		def save_token
			self.remember_token = User.digest(User.new_token)
		end
end