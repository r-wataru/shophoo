# == Schema Information
#
# Table name: bookmark_folders
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  data       :text
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bookmark_folder do
  end
end
