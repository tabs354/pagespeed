require 'faker'

10.times do
  email = Faker::JapaneseMedia::OnePiece.unique.character.delete(' ') + "@example.com"
  puts "User: #{email}"
  User.create(email: email,
              password: "password")
end

user = User.first
user.role = "admin"
user.save
puts "Admin: #{user.email} Password: password"