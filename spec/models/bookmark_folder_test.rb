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

require 'test_helper'

class BookmarkFolderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
