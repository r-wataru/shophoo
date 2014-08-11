FactoryGirl.define do
  factory :item do
    organization { create(:organization) }
    sequence(:display_name) { |n| "Item #{n}" }
    sequence(:code_name) { |n| "item_#{n}"}
    price 500
    listable true
    
    factory :listable_item do
      automatic true
      price 500
    end
  end
end
