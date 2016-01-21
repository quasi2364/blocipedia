include RandomData

15.times do
	user = User.new(
		email: Faker::Internet.free_email,
		password: "password"
	)
	user.skip_confirmation!
	user.save!
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

100.times do
	collab = Collaborator.create!(
		wiki: wikis.sample,
		user: users.sample
	)
end
collabs = Collaborator.all

user = User.create!(
	email: "dlevin64@gmail.com",
	password: "password"
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{Collaborator.count} Collaborators created"