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

class Organization < Account
  has_many :items
  has_many :manager_roles, dependent: :destroy
  has_many :managers, class_name: "User", through: :manager_roles, source: :user
  has_many :histories
  has_many :owner_roles, ->{ where(owner: true) }, class_name: "ManagerRole"
  has_many :owning_histories, class_name: "History"
  has_one :organization_address
  has_one :image, class_name: "OrganizationImage", dependent: :destroy
  has_one :design, class_name: "DesignImage", dependent: :destroy

  accepts_nested_attributes_for :organization_address, allow_destroy: true
  accepts_nested_attributes_for :image, allow_destroy: true
  accepts_nested_attributes_for :design, allow_destroy: true

  attr_accessor :owner_user

  after_create do
    self.create_organization_address unless self.organization_address
  end

  validates :real_name, presence: true
  scope :active, ->{ where(deleted_at: nil) }

  def owners
    managers.where("manager_roles.owner" => true)
  end

  def add_owner(user)
    ManagerRole.create!(user_id: user.id, organization_id: id, owner: true)
  end

  def add_manager(user)
    ManagerRole.create!(user_id: user.id, organization_id: id, owner: false)
  end

  def history_users
    User.joins(:histories).where('histories.item_id' => owning_item_ids)
  end

  def discard
    self.screen_name = screen_name + "+" + SecureRandom.hex
    self.deleted_at = Time.current
    self.save!
  end

  def destroy_organization
    self.screen_name = screen_name + "+" + SecureRandom.hex
    self.class.transaction do
      self.deleted_at = Time.current
      save!
      owning_items.each do |it|
        it.discard
      end
      manager_roles.each do |role|
        role.destroy
      end
      histories.each do |hi|
        hi.destroy
      end
    end
  end
end
