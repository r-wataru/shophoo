require 'spec_helper'

describe ShoppingCart, 'FactoryGirl' do
  Given(:cart) { create(:shopping_cart) }
  Then { expect(cart.created_at).to eq(TimeZero) }
  Then { expect(cart.updated_at).to eq(TimeZero) }
end
