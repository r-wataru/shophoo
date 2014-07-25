# == Schema Information
#
# Table name: user_tokens
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  value      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_token do
  end
end
