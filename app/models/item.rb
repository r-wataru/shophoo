# == Schema Information
#
# Table name: items
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  code_name       :string(255)      not null
#  display_name    :string(255)      not null
#  price           :integer          default(0), not null
#  deleted_at      :datetime
#  view_count      :integer          default(0), not null
#  listable        :boolean          default(FALSE), not null
#  description     :text
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_items_on_organization_id  (organization_id)
#

require 'securerandom'
class Item < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :organization
  has_many :histories
  has_many :history_users, through: :histories, source: :user
  has_one :image, class_name: "ItemImage", dependent: :destroy
  accepts_nested_attributes_for :image, allow_destroy: true
  attr_accessor :data

  scope :listable, -> { where(listable: true, deleted_at: nil) }
  scope :active, -> { where(deleted_at: nil) }
  scope :list_price, -> { where("price is NOT NULL")}

  validates :code_name, presence: true, uniqueness: { scope: :organization_id },
    format: { with: /\A[a-z0-9_+-]+\z/, allow_blank: true }
  validates :display_name, presence: true
  validates :price, presence: true, numericality: { allow_blank: true }
  validate :check_price

  before_validation do
    if deleted_at.present? && !code_name.match(/\+[0-9a-f]{32}/)
      self.code_name += '+' + SecureRandom.hex
      self.deleted_at = Time.current if self.deleted_at.nil?
    end
  end

  def display_price
    "¥ #{price}"
  end

  def display_show
    listable? ? "Showing" : "Secret"
  end

  private
  def check_price
    if price.present? && price == 0
      errors.add(:price, :price_up)
    end
  end
end
