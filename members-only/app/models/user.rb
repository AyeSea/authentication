class User < ActiveRecord::Base
	before_create :save_token


	validates :username, presence: true, uniqueness: true, length: { in: 5..20 }
	validates :email, presence: true, uniqueness: { case_sensitive: false },
										length: { in: 5..30 }

	has_secure_password
	validates :password, length: { in: 8..30 }

	private
		def save_token
			self.remember_token = User.encrypt_token
		end

		def User.encrypt_token
			Digest::SHA1.hexdigest(User.create_token)
		end

		def User.create_token
			SecureRandom.urlsafe_base64
		end
end