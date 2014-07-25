FactoryGirl.define do
  factory :new_email do
    user { create(:user) }
    address { "#{user.screen_name}@example.com" }
  end
end
