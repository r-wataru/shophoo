require 'spec_helper'

describe Item do
  context 'FactoryGirl' do
    When(:item) { create(:item) }
    Then { expect(item.created_at).to eq(TimeZero) }
    Then { expect(item.updated_at).to eq(TimeZero) }
  end

  context 'Code Name Validation' do
    Given(:item) { build(:item, code_name: "a b c") }
    Given(:item2) { build(:item, code_name: "a.bc") }
    Given(:item3) { build(:item, code_name: "a-bc") }
    Then { expect(item).not_to be_valid }
    Then { expect(item2).not_to be_valid }
    Then { expect(item3).to be_valid }
  end
end