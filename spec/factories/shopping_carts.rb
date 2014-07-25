FactoryGirl.define do
  factory :shopping_cart do
    user { create(:user) }
  end
end
