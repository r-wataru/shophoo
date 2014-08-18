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
#  company_name    :string(255)
#  about           :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Address < ActiveRecord::Base
  include PhoneNumbers
  include ActiveModel::ForbiddenAttributesProtection

  def formatted_zip_code
    case country_code
    when 'JP'
      if md = zip_code.match(/\A(\d{3})(\d{4})\z/)
        md[1] + '-' + md[2]
      end
    else
      zip_code
    end
  end

  def country_name
    I18n.t(country_code, scope: :countries) if country_code
  end
end
