FactoryGirl.define do
  factory :user_image do
    user { FactoryGirl.create(:user)}
    data { File.new(Rails.root.join("spec/factories/data", "1x1.png"), "rb").read }
    content_type "image/png"
  end
end