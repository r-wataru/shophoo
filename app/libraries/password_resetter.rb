class PasswordResetter
  include ActiveAttr::Model

  attr_accessor :email

  def send_resetter_mail
    if user = User.find_by_email(email)
      user_token = UserToken.create!(user_id: user.id)
      AccountMailer.forget_password(user, user_token).deliver
    end
  end
end
