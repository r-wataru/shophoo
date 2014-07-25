FactoryGirl.define do
  factory :manager_role do
    user { create(:user) }
    organization { create(:organization) }
    owner true
  end
end
