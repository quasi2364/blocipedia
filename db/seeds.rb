include RandomData

15.times do
	user = User.create!(
		email: Faker::Internet.free_email,
		password: "password"
	)
end
users = User.all

15.times do
	wiki = Wiki.create!(
		title: Faker::Lorem.sentence,
		body: Faker::Lorem.paragraph(10),
		user: users.sample
	)
end
wikis = Wiki.all

user = User.create!(
	email: "dlevin64@gmail.com",
	password: "password"
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"