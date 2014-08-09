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

class WorkAddress < Address
  belongs_to :user

  validates :user_id, uniqueness: true

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
end
