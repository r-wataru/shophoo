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

require 'securerandom'
class Item < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :organization
  has_many :histories
  has_many :history_users, through: :histories, source: :user
  has_one :image, class_name: "ItemImage", dependent: :destroy

  accepts_nested_attributes_for :image, allow_destroy: true

  scope :listable, -> { where(listable: true, deleted_at: nil) }
  scope :active, -> { where(deleted_at: nil) }
  scope :list_price, -> { where("price is NOT NULL")}

  def display_price
    "¥ #{price}"
  end

  def display_show
    listable? ? "Showing" : "Secret"
  end
end
