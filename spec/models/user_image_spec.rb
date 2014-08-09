require 'spec_helper'

describe UserImage, '#save' do
  Given(:user_image) { create(:user_image) }
  Then { expect(user_image.created_at).to eq(TimeZero) }
  Then { expect(user_image.updated_at).to eq(TimeZero) }
  Then { expect(user_image.data).not_to be_nil }
  Then { expect(user_image.thumbnail_data).not_to be_nil }
end
