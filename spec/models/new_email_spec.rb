require 'spec_helper'

describe NewEmail, 'FactoryGirl' do
  Given(:new_email) { create(:new_email) }
  Then { expect(new_email.created_at).to eq(TimeZero) }
  Then { expect(new_email.updated_at).to eq(TimeZero) }
end

describe NewEmail, 'Validations' do
  context '不正な形式のアドレスの場合' do
    Given(:new_email) { build(:new_email, address: 'foo@bar@example.com') }
    Then { expect(new_email).not_to be_valid }
  end

  context '空のアドレスの場合' do
    Given(:new_email) { build(:new_email, address: '') }
    Then { expect(new_email).not_to be_valid }
  end

  context 'アドレスが重複する場合' do
    Given(:email) { create(:email) }
    Given(:new_email) { build(:new_email, address: email.address) }
    Then { expect(new_email).not_to be_valid }
  end
end

describe NewEmail, '#confirm' do
  Given!(:user) { create(:user) }
  Given!(:new_email) { create(:new_email, user: user) }

  context 'トークンが有効な場合' do
    When(:result) { new_email.confirm(new_email.confirmation_token) }
    Then { expect(result).to eq(:confirmed) }
    Then { expect(user.emails.size).to eq(1) }
    Then { expect(user.emails.first).to be_main }
    Then { expect(new_email).to be_used }
  end

  context '2個目のメールである場合' do
    Given { create(:email, user: user, main: true) }
    When(:result) { new_email.confirm(new_email.confirmation_token) }
    Then { expect(user.emails.last).not_to be_main }
  end

  context 'トークンが無効な場合' do
    When(:result) { new_email.confirm('x' * 32) }
    Then { expect(result).to eq(:invalid) }
    Then { expect(user).to have(:no).emails }
    Then { expect(new_email).not_to be_used }
  end

  context 'トークンが使用済みの場合' do
    Given { new_email.update_column(:used, true) }
    When(:result) { new_email.confirm(new_email.confirmation_token) }
    Then { expect(result).to eq(:used) }
    Then { expect(user).to have(:no).emails }
    Then { expect(new_email).to be_used }
  end

  context '有効期限切れの場合' do
    Given { Timecop.freeze(Time.now + NewEmail::VALIDITY_PERIOD_IN_HOURS * 3600 + 1) }
    When(:result) { new_email.confirm(new_email.confirmation_token) }
    Then { expect(result).to eq(:expired) }
    Then { expect(user).to have(:no).emails }
    Then { expect(new_email).not_to be_used }
  end
end
