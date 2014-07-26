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

class User < Account
  include MiniAuth

  has_many :emails
  has_many :new_emails
  has_many :manager_roles
  has_many :managing_organizations, through: :manager_roles, source: :organization
  has_many :owner_roles, ->{ where(owner: true) }, class_name: "ManagerRole"
  has_many :organizations, through: :owner_roles, source: :organization
  has_many :histories, dependent: :destroy
  has_many :items, through: :histories, dependent: :destroy
  has_one :shopping_cart
  has_one :private_address
  has_one :work_address
  has_one :bookmark_folder
  has_one :user_token
  has_one :image, class_name: "UserImage", dependent: :destroy

  accepts_nested_attributes_for :private_address, allow_destroy: true
  accepts_nested_attributes_for :work_address, allow_destroy: true
  accepts_nested_attributes_for :image, allow_destroy: true

  attr_reader :new_email
  attr_reader :email
  attr_accessor :creating_user

  validates :sex, inclusion: { in: %w{male female}, allow_nil: true, allow_blank: true }
  validate :check_creating_user

  scope :active, ->{ where(deleted_at: nil) }

  after_create do
    self.create_shopping_cart
    self.create_bookmark_folder
    self.create_private_address unless self.private_address
    self.create_work_address unless self.work_address
  end

  def show_screen_name
    sex == "male" ? "Mr. " + screen_name : "Ms. " + screen_name
  end

  def full_name
    [ family_name, given_name ].compact.join(' ')
  end

  def deleted?
    !deleted_at.nil?
  end

  def new_email=(address)
    self.new_emails.build(address: address)
    @new_email = address
  end

  def email=(address)
    self.emails.build(address: address)
  end

  def send_token
    user_token = UserToken.new
    user_token.user = self
    user_token.save
    AccountMailer.new_user(new_emails.last, user_token).deliver
  end

  def make_token_and_deliver(organization)
    manager_token = ManagerToken.new
    manager_token.user = self
    manager_token.organization = organization
    manager_token.save
    AccountMailer.add_manager(self, manager_token).deliver
  end

  def age
    if self.birthday.present?
      now = Time.now.to_date
      now.year - self.birthday.year - (self.birthday.to_date.change(year: now.year) > now ? 1 : 0)
    end
  end

  def destroy_user
    self.screen_name = screen_name + "+" + SecureRandom.hex
    self.class.transaction do
      emails.where(deleted_at: nil).each do |email|
        email.main = false
        email.delete
      end
      self.deleted_at = Time.current
      save!
      organizations.each do |org|
        org.items.each do |it|
          it.discard
        end
        org.discard
      end
      manager_roles.each do |role|
        role.destroy
      end
      histories.each do |his|
        his.destroy
      end
    end
  end

  def private_address_value
    arr = []
    arr << self.private_address.zip_code if self.private_address.zip_code.present?
    arr << self.private_address.state if self.private_address.state.present?
    arr << self.private_address.city if self.private_address.city.present?
    arr << self.private_address.address1 if self.private_address.address1.present?
    arr << self.private_address.address2 if self.private_address.address2.present?
    arr.compact
  end

  def work_address_value
    arr = []
    arr << self.work_address.zip_code if self.work_address.zip_code.present?
    arr << self.work_address.state if self.work_address.state.present?
    arr << self.work_address.city if self.work_address.city.present?
    arr << self.work_address.address1 if self.work_address.address1.present?
    arr << self.work_address.address2 if self.work_address.address2.present?
    arr.compact
  end

  class << self
    def find_by_email(address)
      Email.where(address: address, deleted_at: nil).first.try(:user)
    end
  end

  private
  # 新規作成時のパスワードのValidation
  def check_creating_user
    if creating_user.present?
      if password.blank?
        errors.add(:password, :blank)
      end
    end
  end
end
