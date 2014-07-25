require 'spec_helper'

describe BookmarkFolder, 'FactoryGirl' do
  Given(:bookmark_folder) { create(:bookmark_folder) }
  Then { expect(bookmark_folder.created_at).to eq(TimeZero)}
  Then { expect(bookmark_folder.updated_at).to eq(TimeZero)}
end
