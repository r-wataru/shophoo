FactoryGirl.define do
  factory :email do
    user { create(:user) }
    address { "#{user.screen_name}@example.com" }
  end
end
