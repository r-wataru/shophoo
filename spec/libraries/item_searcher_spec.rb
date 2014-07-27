require 'spec_helper'

describe ItemSearcher, "#search" do
  context 'チャンネル名で検索' do
    Given!(:user) { create(:user_with_email)}
    Given!(:organization) { create(:organization) }
    Given!(:item1) { create(:item, display_name: 'ABC', listable: true, organization: organization) }
    Given!(:item2) { create(:item, display_name: 'XYZ', listable: true, organization: organization) }
    When(:result) { ItemSearcher.new(query: 'XY').search }
    Then { expect(result).to have(1).item }
  end
end