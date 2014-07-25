FactoryGirl.define do
  factory :organization do
    sequence(:screen_name) { |n| "organization#{n}" }
    sequence(:real_name) { |n| "Organization#{n}" }
  end
end
