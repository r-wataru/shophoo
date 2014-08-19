# == Schema Information
#
# Table name: new_emails
#
#  id                 :integer          not null, primary key
#  user_id            :integer          not null
#  address            :string(255)      not null
#  confirmation_token :string(255)      not null
#  used               :boolean          default(FALSE), not null
#  created_at         :datetime
#  updated_at         :datetime
#

class NewEmail < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include MiniAuth::RandomToken

  VALIDITY_PERIOD_IN_HOURS = 24

  belongs_to :user
  attr_accessor :password, :add_new_email

  token :confirmation

  validates :address, presence: true, email: true
  validate :check_password_email

  validate do
    if address.present? && Email.where(address: address).exists?
      errors.add(:address, :taken)
    end
  end

  before_create do
    generate_confirmation_token unless confirmation_token
  end

  def confirm(token)
    return :invalid unless verify_confirmation_token(token)
    return :expired if Time.current > created_at + VALIDITY_PERIOD_IN_HOURS * 3600
    return :used if used
    self.class.transaction do
      user.emails << Email.new(address: address, main: !user.emails.active.exists?)
      update_column(:used, true)
    end
    :confirmed
  end

  def send_mail
    user_token = UserToken.new
    user_token.user = self.user
    user_token.save
    AccountMailer.add_email(self, user_token).deliver
  end

  private
  def check_password_email
    if add_new_email.present?
      unless PasswordChecker.verify(self.user, password)
        errors.add(:password, :wrong_password)
      end
    end
  end
end
