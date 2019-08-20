require 'faker'

5.times do
  email = Faker::JapaneseMedia::OnePiece.unique.character.delete(' ') + "@example.com"
  puts "User: #{email}"
  User.create(email: email,
              password: "password")
end

20.times do
  dns = Faker::App.name.delete(" ")
  dns = "www." + dns.downcase + ".com"
  DomainNameService.create(dns: dns,
                 status: [:off, :on].sample,
                 user_id: Faker::Number.within(range: 1..5))
  puts "DNS: #{dns}"
end

user = User.first
user.role = "admin"
user.save
puts "Admin: #{user.email} Password: password"