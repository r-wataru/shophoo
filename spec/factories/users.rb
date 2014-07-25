FactoryGirl.define do
  factory :user do
    sequence(:screen_name) { |n| "user#{n}" }
    family_name '山田'
    given_name '太郎'
    password "password"
    setting_password true
    sex 'male'
    birthday '1980-08-01'
    checked true

    factory :user_with_email do
      after(:create) do |user, evaluator|
        create(:email, user: user, main: true)
      end
    end

    factory :full_user do
      after(:create) do |user, evaluator|
        create(:email, user: user, main: true)
        if user.private_address
          user.private_address(
            country_code: 'JP',
            zip_code: '1050012',
            state: '東京都',
            city: '港区',
            address1: '大門1-1-1',
            address2: 'マンション大門101',
            phone: '03-0000-0000',
            mobile: '090-0000-0000',
            fax: '03-0000-0001')
          user.save
        else
          create(:private_address, user: user)
        end
        if user.work_address
          user.work_address(
            country_code: 'JP',
            zip_code: "1000000",
            state: '東京都',
            city: '千代田区',
            address1: '千代田１-１-１',
            address2: '')
          user.save
        else
          create(:work_address, user: user)
        end
      end
    end
  end
end
