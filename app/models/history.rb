# == Schema Information
#
# Table name: histories
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  organization_id :integer          not null
#  item_id         :integer          not null
#  message         :text
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_histories_on_user_id_and_item_id  (user_id,item_id) UNIQUE
#

class History < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  belongs_to :item
end
