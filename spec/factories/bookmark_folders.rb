FactoryGirl.define do
  factory :bookmark_folder do
    user { create(:user)}
  end
end
