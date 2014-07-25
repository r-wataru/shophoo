require 'spec_helper'

describe User, 'FactoryGirl' do
  Given(:user) { create(:user) }
  Then { expect(user.created_at).to eq(TimeZero) }
  Then { expect(user.updated_at).to eq(TimeZero) }
end

describe User, 'validation on screen_name (uniqueness)' do
  Given(:screen_name) { 'alice' }
  Given(:user) { build(:user, screen_name: screen_name) }
  When { create(:user, screen_name: screen_name) }
  Then { expect(user).not_to be_valid }
  And { expect(user.errors[:screen_name]).to be_present }
end

describe User, 'validation on sex (inclusion)' do
  Given(:screen_name) { 'alice' }
  When(:user) { build(:user, sex: 'other') }
  Then { expect(user).not_to be_valid }
  And { expect(user.errors[:sex]).to be_present }
end

describe User, '#managing_organizations' do
  Given(:user) { create(:user) }
  Given(:organization) { create(:organization) }
  When { user.managing_organizations << organization }
  Then { expect(user).to have(1).managing_organization }
end

describe User, '#organizations' do
  Given(:user) { create(:user) }
  Given(:organization) { create(:organization) }
  When { user.organizations << organization }
  Then { expect(user).to have(1).organization }
end

describe User, '#authenticate' do
  Given(:password) { "password" }
  Given(:user) { create(:user, password: password) }
  When(:result) { user.authenticate(password) }
  Then { expect(result).to eq(user) }
end

describe User, '#new_email=' do
  Given(:email_address) { 'alice@example.com' }
  When(:user) { create(:user, new_email: email_address) }
  Then { expect(user.new_emails.first.address).to eq(email_address) }
end

describe User, '.find_by_email' do
  Given(:email) { create(:email) }
  When(:result) { User.find_by_email(email.address) }
  Then { expect(result).to eq(email.user) }
end

describe User, "Validation on screen_name(not use)" do
  Given(:user) { build(:user_with_email, screen_name: "a b c") }
  Given(:user2) { build(:user_with_email, screen_name: "user") }
  Given(:user3) { build(:user_with_email, screen_name: "a.bc") }
  Given(:user4) { build(:user_with_email, screen_name: "watanabe") }
  Then { expect(user).not_to be_valid }
  Then { expect(user2).not_to be_valid }
  Then { expect(user3).not_to be_valid }
  Then { expect(user4).to be_valid }
end

