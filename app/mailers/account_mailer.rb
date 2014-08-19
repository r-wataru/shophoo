# coding: utf-8

class AccountMailer < ActionMailer::Base
  default charset: 'ISO-2022-JP', from: Shophoo::MailFrom

  def new_user(new_email, user_token)
    @user = new_email.user
    @user_token = user_token
    mail(to: new_email.address, subject: "Shophoo パスワードの登録確定")
  end

  def add_email(new_email, user_token)
    @user = new_email.user
    @user_token = user_token
    to = []
    to << new_email.address
    mail(to: to, subject: "Shophoo メールアドレスの追加")
  end

  def forget_password(user, user_token)
    @user = user
    @user_token = user_token
    email_address = user.emails.active.main.present? ? user.emails.active.main.first.address : user.emails.last.address
    mail(to: email_address, subject: "Shophoo パスワード再設定")
  end
end
