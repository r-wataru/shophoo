require 'spec_helper'

describe Email, 'FactoryGirl' do
  Given(:email) { create(:email) }
  Then { expect(email.created_at).to eq(TimeZero) }
  Then { expect(email.updated_at).to eq(TimeZero) }
end

describe Email, 'Validations' do
  context '不正な形式のアドレスの場合' do
    Given(:email) { build(:email, address: 'foo@bar@example.com') }
    Then { expect(email).not_to be_valid }
  end

  context '空のアドレスの場合' do
    Given(:email) { build(:email, address: '') }
    Then { expect(email).not_to be_valid }
  end

  context 'mainかつdeletedの場合' do
    Given(:email) { build(:email, main: true, deleted_at: Time.current) }
    Then { expect(email).not_to be_valid }
  end
end

describe Email, '#set_main' do
  Given!(:main_email) { create(:email, main: true) }
  Given!(:email) { create(:email, user: main_email.user, address: 'test@example.com') }
  When { email.set_main }
  Then { expect(email).to be_main }
  And { expect(main_email.reload).not_to be_main }
end

describe Email, '#delete' do
  context 'mainではない場合' do
    Given(:email1) { create(:email, main: true) }
    Given(:email2) { create(:email, user: email1.user, address: 'test@example.com') }
    When(:result) { email2.delete }
    Then { expect(result).to be_true }
    And { expect(email2.reload.address).to match(/\+[0-9a-f]{32}\z/) }
  end

  context 'mainの場合' do
    Given(:email1) { create(:email, main: true) }
    Given(:email2) { create(:email, user: email1.user, address: 'test@example.com') }
    When(:result) { email1.delete }
    Then { expect(result).to be_false }
  end
end
