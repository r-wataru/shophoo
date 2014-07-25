# coding: utf-8

module RequestsSpecHelper
  def login_as(user, password = 'password')
    Hermit::MEMCACHED.delete("session_token.#{user.id}")
    post '/session', login: user.emails.first.address, password: password
  end
end
