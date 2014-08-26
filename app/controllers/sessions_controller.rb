class SessionsController < ApplicationController
  skip_before_filter :authenticate_user
  layout "before_authentication"

  def new
    if current_user
      redirect_to :root
    end
  end

  def create
    if user = PasswordAuthenticator.verify(params[:login], params[:password])
      if user && user.checked == true
        session[:current_user_id] = user.id
        user.update_column(:logged_at, Time.current)
        if params[:from].present?
          flash.notice = t(".complete")
          redirect_to params[:from]
        else
          flash.notice = t(".complete")
          redirect_to :root
        end
      end
    else
      flash.now.alert = t(".invalid_login_or_password")
      render action: :new
    end
  end

  def destroy
    if current_user
      session.delete(:current_user_id)
      redirect_to :root
    end
  end
end