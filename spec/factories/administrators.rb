FactoryGirl.define do
  factory :administrator do
    login_name "wataru"
    password "password"
    setting_password true
    super_user true
  end
end
