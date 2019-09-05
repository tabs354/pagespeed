FactoryBot.define do
  factory :pagespeed_insight do
    lighthouse_result {}
    overall_results {}
    field_paint {}
    field_input {}
    origin_paint {}
    origin_input {}
  end
end