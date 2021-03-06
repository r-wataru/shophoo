FactoryGirl.define do
  factory :organization_image do
    organization { FactoryGirl.create(:organization)}
    data { File.new(Rails.root.join("spec/factories/data", "1x1.png"), "rb").read }
    content_type "image/png"
  end
end