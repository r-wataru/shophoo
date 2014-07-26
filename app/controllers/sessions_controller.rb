class SessionsController < ApplicationController
  layout "before_authentication"
  
  def new
  end
  
  def create
    if user = PasswordAuthenticator.verify(params[:login], params[:password])
      if user && user.checked == true
        session[:current_user_id] = user.id
        user.update_column(:logged_at, Time.current)
        if params[:from].present?
          flash.notice = "Complete"
          redirect_to params[:from]
        else
          flash.notice = "Complete"
          redirect_to :root
        end
      end
    else
      flash.now.alert = "Login name or password is incorrect."
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