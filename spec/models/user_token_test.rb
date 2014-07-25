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

require 'test_helper'

class UserTokenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
