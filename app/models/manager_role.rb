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
# Indexes
#
#  index_manager_roles_on_user_id_and_organization_id  (user_id,organization_id) UNIQUE
#

class ManagerRole < ActiveRecord::Base
end
