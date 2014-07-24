# == Schema Information
#
# Table name: addresses
#
#  id              :integer          not null, primary key
#  type            :string(255)      not null
#  user_id         :integer
#  organization_id :integer
#  country_code    :string(255)
#  zip_code        :string(255)
#  state           :string(255)
#  city            :string(255)
#  address1        :string(255)
#  address2        :string(255)
#  phone           :string(255)
#  mobile          :string(255)
#  fax             :string(255)
#  birthday        :date
#  sex             :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Address < ActiveRecord::Base
end
