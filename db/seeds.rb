User.create!(name:  "Cooper Luetje",
             email: "koopaluigi@hotmail.com",
             username: "koopaluigi",
             password:              "toadstool",
             password_confirmation: "toadstool",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@perspective.org"
  username = "username#{n+1}"
  password = "password"
  User.create!(name:  name,
               email: email,
               username: username,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
