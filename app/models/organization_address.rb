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
#  created_at      :datetime
#  updated_at      :datetime
#

class OrganizationAddress < Address
  include PhoneNumbers
  
  belongs_to :organization
  validates :organization_id, uniqueness: true
  
  validates :address1,
    zenkaku: { allow_blank: true }
  validates :address2,
    zenkaku: { allow_blank: true }
  validates :city,
    zenkaku: { allow_blank: true }
  validates :state,
    zenkaku: { allow_blank: true }
  validates :zip_code,
    hankaku: { allow_blank: true, type: :number },
    length: { allow_blank: true, is: 7 }
  
  phone_columns :phone, :fax, :mobile

  def full_address
    [ self.state, self.city, self.address1, self.address2 ].compact.join(' ')
  end
  
  def show_phone
    self.phone.present? ? phone : "-"
  end
  
  def show_fax
    self.fax.present? ? fax : "-"
  end
  
  def show_mobile
    self.mobile.present? ? mobile : "-"
  end
end
