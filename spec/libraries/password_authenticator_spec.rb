# coding: utf-8

require 'spec_helper'

describe PasswordAuthenticator, '.verify' do
  Given(:email) { 'test@example.com' }
  Given(:password) { 'password' }
  Given(:wrong_email) { 'foobar@example.com' }
  Given(:wrong_password) { 'foobar' }
  Given(:user) { mock_model(User, email: email, password: password, deleted_at: nil) }

  context 'メールアドレスもパスワードも正しい場合' do
    Given { User.stubs(:find_by_email).returns(user) }
    Given { user.stubs(:authenticate).returns(user) }
    When(:result) { PasswordAuthenticator.verify(user.email, password) }
    Then { expect(User).to have_received(:find_by_email).with(user.email) }
    Then { expect(user).to have_received(:authenticate).with(user.password) }
    Then { expect(result).to eq(user) }
  end

  context 'メールアドレスは正しいが、パスワードが誤っている場合' do
    Given { User.stubs(:find_by_email).returns(user) }
    Given { user.stubs(:authenticate).returns(false) }
    When(:result) { PasswordAuthenticator.verify(user.email, wrong_password) }
    Then { expect(User).to have_received(:find_by_email).with(user.email) }
    Then { expect(user).to have_received(:authenticate).with(wrong_password) }
    Then { expect(result).to be_false }
  end

  context 'メールアドレスが誤っている場合' do
    Given { User.stubs(:find_by_email).returns(nil) }
    When(:result) { PasswordAuthenticator.verify(wrong_email, password) }
    Then { expect(User).to have_received(:find_by_email).with(wrong_email) }
    Then { expect(result).to be_false }
  end

  context 'メールアドレスが空の場合' do
    Given { User.stubs(:find_by_email) }
    When(:result) { PasswordAuthenticator.verify('', password) }
    Then { expect(User).to have_received(:find_by_email).never }
    Then { expect(result).to be_false }
  end

  context 'パスワードが空の場合' do
    Given { User.stubs(:find_by_email) }
    When(:result) { PasswordAuthenticator.verify(email, '') }
    Then { expect(User).to have_received(:find_by_email).never }
    Then { expect(result).to be_false }
  end
end
