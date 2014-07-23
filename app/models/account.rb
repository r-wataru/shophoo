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
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_accounts_on_screen_name  (screen_name) UNIQUE
#

class Account < ActiveRecord::Base
end
