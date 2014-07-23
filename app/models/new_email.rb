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
end
