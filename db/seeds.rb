# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"

# Create Users
5.times do
	user = User.new(
		name:     Faker::Name.name,
		email:    Faker::Internet.email,
		password: Faker::Lorem.characters(10)
		)
	user.skip_confirmation!
	user.save!
end
users = User.all

# Note: by calling `User.new` instead of `create`,
# we create an instance of User which isn't immediately saved to the database.

# The `skip_confirmation!` method sets the `confirmed_at` attribute
# to avoid triggering an confirmation email when the User is saved.

# The `save` method then saves this User to the database.

# Create Posts
50.times do
	Post.create!(
		user:   users.sample,
		title: Faker::Lorem.sentence,
		body: Faker::Lorem.paragraph)
end

posts = Post.all

# Create comments
100.times do
	Comment.create!(
		# user: users.sample,   # we have not yet associated Users with Comments
		post: posts.sample,
		body: Faker::Lorem.paragraph)
end

user = User.first
user.skip_reconfirmation!
user.update_attributes!(
	email: 'e@y.com',
	password: 'password'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"