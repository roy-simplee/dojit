# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"

# Create posts
50.times do
	Post.create!(
		title: Faker::Lorem.sentence,
		body: Faker::Lorem.paragraph)
end

posts = Post.all

# Create comments
100.times do
	Comment.create!(
		post: posts.sample,
		body: Faker::Lorem.paragraph)
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"