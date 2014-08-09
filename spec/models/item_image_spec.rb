require 'spec_helper'

describe ItemImage, '#save' do
  Given(:item_image) { create(:item_image) }
  Then { expect(item_image.created_at).to eq(TimeZero) }
  Then { expect(item_image.updated_at).to eq(TimeZero) }
  Then { expect(item_image.data1).not_to be_nil }
  Then { expect(item_image.data2).not_to be_nil }
  Then { expect(item_image.data3).not_to be_nil }
  Then { expect(item_image.thumbnail_data).not_to be_nil }
end
