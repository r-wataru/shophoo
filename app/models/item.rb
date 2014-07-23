# == Schema Information
#
# Table name: items
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  code_name       :string(255)      not null
#  display_name    :string(255)      not null
#  description     :text
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_items_on_organization_id  (organization_id)
#

class Item < ActiveRecord::Base
end
