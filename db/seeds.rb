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
