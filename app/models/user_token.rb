# == Schema Information
#
# Table name: user_tokens
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  value      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_user_tokens_on_value  (value)
#

class UserToken < ActiveRecord::Base
  belongs_to :user

  before_save do
    self.value = UserToken.create_salt
  end

  class << self
    def create_salt
      d = Digest::SHA1.new
      now = Time.now
      d.update(now.to_s)
      d.update(String(now.usec))
      d.update(String(rand(0)))
      d.update(String($$))
      d.update('hermit')
      d.hexdigest
    end
  end
end
