# coding: utf-8

require 'spec_helper'

describe SessionsController, 'on POST create' do
  Given(:user) { stub_model(User, email: 'test@example.com', password: 'password') }

  context 'パスワード認証に成功した場合' do
    Given(:user) { stub_model(User, email: 'test@example.com', password: 'password', checked: true) }
    Given { PasswordAuthenticator.stubs(:verify).returns(user) }
    When { post :create, email: user.email, password: user.password }
    Then do
      expect(PasswordAuthenticator).
        to have_received(:verify).with(user.email, user.password)
    end
    Then { expect(session[:current_user_id]).to eq(user.id) }
  end

  context 'パスワード認証に失敗した場合' do
    Given(:wrong_password) { 'foobar' }
    Given { PasswordAuthenticator.stubs(:verify).returns(false) }
    When { post :create, email: user.email, password: wrong_password }
    Then do
      expect(PasswordAuthenticator).
        to have_received(:verify).with(user.email, wrong_password)
    end
    Then { expect(session).not_to have_key(:current_user_id) }
  end
end