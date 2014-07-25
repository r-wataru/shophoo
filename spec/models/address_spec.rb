require 'spec_helper'

describe Address do
  Given(:user) { create(:user) }
  When { user.private_address.country_code = 'JP'}
  Then { expect(user.private_address.country_code).to eq('JP')}
end
