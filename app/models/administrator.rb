# == Schema Information
#
# Table name: administrators
#
#  id              :integer          not null, primary key
#  login_name      :string(255)      not null
#  password_digest :string(255)      not null
#  super_user      :boolean          default(FALSE), not null
#  created_at      :datetime
#  updated_at      :datetime
#

class Administrator < ActiveRecord::Base
end
