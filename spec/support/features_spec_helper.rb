# coding: utf-8

module FeaturesSpecHelper
  def login_as(user, password = 'password')
    Hermit::MEMCACHED.delete("session_token.#{user.id}")
    visit new_session_path
    within('#session') do
      fill_in 'login', with: user.emails.first.address
      fill_in 'password', with: password
      find('input[type="submit"]').click
    end
  end

  def login_as_administrator(admin, password = 'password')
    visit admin_root_path
    within("#session") do
      fill_in "ログイン名", with: admin.login_name
      fill_in "パスワード", with: password
      find('input[type="submit"]').click
    end
  end

  def submit
    find('input[type="submit"]').click
  end

  def debug
    save_and_open_page
  end
end
