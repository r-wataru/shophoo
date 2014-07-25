FactoryGirl.define do
  factory :private_address do
    user { create(:user) }
    country_code 'JP'
    zip_code '1050012'
    state '東京都'
    city '港区'
    address1 '大門1-1-1'
    address2 'マンション大門101'
    phone '03-0000-0000'
    mobile '03-0000-0000'
    fax '03-0000-0001'
  end
end
