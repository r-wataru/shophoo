# == Schema Information
#
# Table name: bookmark_folders
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  data       :text
#  created_at :datetime
#  updated_at :datetime
#

class BookmarkFolder < ActiveRecord::Base
  belongs_to :user

  def data=(hash)
    self[:data] = ActiveSupport::JSON.encode(hash) if hash.kind_of?(Hash)
  end

  def data
    hash = self[:data] ? ActiveSupport::JSON.decode(self[:data]) : {}
    Object::HashWithIndifferentAccess.new(hash)
  end

  def add_item(object)
    items = data[:items] || Array.new
    data_array = self.data[:items].map{|a| a[:id]} if self.data[:items]
    if (data_array && !data_array.include?(object.id)) || items.blank?
      items << { type: object.class.to_s, id: object.id }
      self.data = data.merge(items: items)
    end
  end

  def remove_item(object)
    items = data[:items] || Array.new
    items.reject! { |item| item[:type] == object.class.to_s && item[:id] == object.id }
    self.data = data.merge(items: items)
  end

  def has_item?(object)
    items = data[:items] || Array.new
    items.any? do |item|
      item[:type] == object.class.to_s && item[:id] == object.id
    end
  end

  def number_of_items
    if data[:items].kind_of?(Array)
      data[:items].size
    else
      0
    end
  end

  def items
    if data[:items].kind_of?(Array)
      ids = data[:items].select { |item| item[:type] == 'Item' }.map { |item| item[:id] }
      cart_items = []
      ids.each do |id|
        i = Item.listable.find(id)
        cart_items << i
      end
      cart_items
    else
      0
    end
  end

  def present?
    number_of_items > 0
  end
end