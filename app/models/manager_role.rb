# == Schema Information
#
# Table name: manager_roles
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  organization_id :integer          not null
#  owner           :boolean          default(FALSE), not null
#  created_at      :datetime
#  updated_at      :datetime
#

class ManagerRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
end
