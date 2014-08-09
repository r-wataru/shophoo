FactoryGirl.define do
  factory :item_image do
    item { FactoryGirl.create(:item)}
    data1 { File.new(Rails.root.join("spec/factories/data", "1x1.png"), "rb").read }
    data2 { File.new(Rails.root.join("spec/factories/data", "1x1.png"), "rb").read }
    data3 { File.new(Rails.root.join("spec/factories/data", "1x1.png"), "rb").read }
    data1_content_type "image/png"
    data2_content_type "image/png"
    data3_content_type "image/png"
  end
end