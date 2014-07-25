FactoryGirl.define do
  factory :subscription do
    channel { create(:item) }
    audience { create(:user_with_email) }
    viewing_time 0
  end
end
