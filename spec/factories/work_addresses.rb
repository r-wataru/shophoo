FactoryGirl.define do
  factory :work_address do
    user { create(:user) }
    country_code 'JP'
    zip_code "1000000"
    state '東京都'
    city '千代田区'
    address1 '千代田1-1-1'
    address2 ''
  end
end
