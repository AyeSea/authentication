# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do |n|
	username = "example_user_#{n + 1}"
	email = "user#{n + 1}@example.com"
	User.create!(username: username,
							 email: email,
							 password: 'password',
							 password_confirmation: 'password')
end