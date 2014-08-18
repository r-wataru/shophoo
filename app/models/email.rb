# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  address    :string(255)      not null
#  main       :boolean          default(FALSE), not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_emails_on_address  (address) UNIQUE
#

require 'securerandom'

class Email < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user

  scope :active, lambda { where(deleted_at: nil) }
  scope :main, lambda { where(main: true) }

  validates :address, presence: true, uniqueness: true, email: true

  validate do
    if main && deleted_at
      errors.add(:deleted_at, :invalid)
    end
  end

  before_save do
    if deleted_at && !address.match(/\+[0-9a-f]{32}\z/)
      self.address = address + "+" + SecureRandom.hex
    end
  end

  def deleted?
    !deleted_at.nil?
  end

  def set_main
    self.class.transaction do
      user.emails.where(main: true).update_all(main: false)
      self.main = true
      self.save!
    end
  end

  def delete
    return false if main?
    self.deleted_at = Time.current
    self.save!
  end
end
