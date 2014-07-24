# == Schema Information
#
# Table name: accounts
#
#  id              :integer          not null, primary key
#  type            :string(255)      not null
#  screen_name     :string(255)      not null
#  real_name       :string(255)
#  family_name     :string(255)
#  given_name      :string(255)
#  password_digest :string(255)
#  logged_at       :datetime
#  checked         :boolean          default(FALSE), not null
#  deleted_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

class Account < ActiveRecord::Base
end
