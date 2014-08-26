class PasswordsController < ApplicationController
  skip_before_filter :authenticate_user

  # GET
  def forgot
    render :forgot, layout: "before_authentication"
  end

  # GET
  def send_mail
    render :send_mail, layout: "before_authentication"
  end

  # POST
  def start_resetting
    resetter = PasswordResetter.new(params[:password_resetter])
    if resetter.send_resetter_mail
      redirect_to :send_mail_password
    else
      redirect_to :forgot_password
    end
  end

  # GET
  def reset_password
    @user_token = UserToken.find_by_value(params[:token])
    @user = @user_token.user
    render :reset_password, layout: "before_authentication"
    unless @user_token
      redirect_to :forgot_password
    end
  end

  # POST
  def update_password
    @user_token = UserToken.find_by_value(params[:token])
    @user = @user_token.user
    if @user_token && @user
      @user.setting_password = true
      if @user.update_attributes params.require(:user).
          permit(:password, :password_confirmation)
        session[:current_user_id] = @user.id
        redirect_to :root
      else
        render :reset_password, layout: "before_authentication"
      end
    else
      render :reset_password, layout: "before_authentication"
    end
  end
end