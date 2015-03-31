class Post < ActiveRecord::Base
	belongs_to :user

	validates :body, presence: true, length: { in: 1..150 }
end
