require 'spec_helper'

describe Item, 'FactoryGirl' do
  When(:item) { create(:item) }
  Then { expect(item.created_at).to eq(TimeZero) }
  Then { expect(item.updated_at).to eq(TimeZero) }
end
