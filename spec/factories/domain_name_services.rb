FactoryBot.define do
  factory :domain_name_service do
    url {}
    https  {true}
    status {"on"}
    user {}
  end
end
