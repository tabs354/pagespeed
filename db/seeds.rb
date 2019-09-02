require 'faker'

5.times do
  email = Faker::JapaneseMedia::OnePiece.unique.character.delete(' ') + "@example.com"
  puts "User: #{email}"
  User.create(email: email, password: 'password')
end

20.times do
  dns = "www." + Faker::App.name.gsub(/\s+/, '-').downcase + ".com"
  DomainNameService.create(dns: dns,
                           status: [:off, :on].sample,
                           user_id: User.pluck(:id).sample)
  puts "DNS: #{dns}"
end

user = User.first
user.role = "admin"
user.save
puts "Admin: #{user.email} Password: password"