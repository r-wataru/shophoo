# coding: utf-8

class PasswordAuthenticator
  class << self
    def verify(login, password)
      return false unless login.present? && password.present?
      user = User.find_by_email(login)
      if user.blank?
        user = User.find_by_screen_name(login)
      end
      user && !user.deleted_at && user.authenticate(password)
    end
  end
end
