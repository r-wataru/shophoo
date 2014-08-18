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
#  birthday        :date
#  sex             :string(255)
#  logged_at       :datetime
#  checked         :boolean          default(FALSE), not null
#  deleted_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_accounts_on_screen_name  (screen_name) UNIQUE
#

class Account < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  validates :screen_name, uniqueness: true, presence: true
  validates :screen_name, format: { with: /\A[a-z0-9_+-]+\z/ }
  validate :check_screen_name
  validate :check_birthday

  private
  def check_screen_name
    if screen_name.present?
      not_path = ["user", "manager", "admin", "organization",
        "group", "member", "channel", "test", "staff"]
      if not_path.include?(screen_name)
        errors.add(:screen_name, :already)
      end
    end
  end

  def check_birthday
    if birthday.present?
      if Date.today < birthday
        errors.add(:birthday, :invalid_date)
      end
    end
  end
end
