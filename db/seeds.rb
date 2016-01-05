include RandomData

15.times do
	user = User.create!(
		email: RandomData.random_email,
		password: "password"
	)
end
users = User.all

15.times do
	wiki = Wiki.create!(
		title: RandomData.random_sentence,
		body: RandomData.random_paragraph,
		user: users.sample
	)
end
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"