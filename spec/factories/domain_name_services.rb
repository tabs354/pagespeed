FactoryBot.define do
  factory :domain_name_service do
    url {Faker::Internet.url}
    https {true}
    status {:on}
    user {}
  end
end
