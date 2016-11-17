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

# Microposts
users = User.order(:created_at).take(6)
content = Faker::Lorem.sentence(5)
picture = open(Faker::Avatar.image)
users.each { |user| user.microposts.create!(content: content, picture: open(Faker::Avatar.image)) }


# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
