require 'spec_helper'

describe Organization, 'FactoryGirl' do
  When(:organization) { create(:organization) }
  Then { expect(organization.created_at).to eq(TimeZero) }
  Then { expect(organization.updated_at).to eq(TimeZero) }
end

describe Organization, 'validation on screen_name (uniqueness)' do
  Given(:screen_name) { 'alice' }
  Given(:organization) { build(:organization, screen_name: screen_name) }
  When { create(:user, screen_name: screen_name) }
  Then { expect(organization).not_to be_valid }
  And { expect(organization.errors[:screen_name]).to be_present }
end

describe Organization, '#managers' do
  Given(:organization) { create(:organization) }
  When { organization.managers << create(:user) }
  Then { expect(organization).to have(1).manager }
end

describe Organization, '#add_owner, #owners' do
  Given(:organization) { create(:organization) }
  Given(:user1) { create(:user) }
  Given(:user2) { create(:user) }
  When do
    organization.add_owner(user1)
    organization.managers << user2
  end
  Then { expect(organization).to have(1).owner }
  And { expect(organization.owners[0]).to eq(user1) }
end
