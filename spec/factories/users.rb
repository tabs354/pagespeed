FactoryBot.define do
  factory :user do
    email {'foo@bar.com'}
    password {'password'}
    role {'staff'}
  end
end