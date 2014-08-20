class TopController < ApplicationController
  skip_before_filter :authenticate_user

  def index
    if current_user
      @items = ItemSearcher.new(query: params[:q]).search
      @items = @items.paginate(page: params[:page], per_page: 10)
      render "index", layout: "application"
    else
      @user = User.new
      render "index", layout: "before_authentication"
    end
  end

  def create
    if request.post?
      @user = User.new user_params
      @user.creating_user = true
      @user.setting_password = true
      if @user.save
        @user.send_token
        @user.emails << Email.new(address: @user.new_emails.last.address, main: true)
        redirect_to action: :thanks
      else
        render "index", layout: "before_authentication"
      end
    else
      redirect_to :root
    end
  end

  def thanks
    render "thanks", layout: "before_authentication"
  end

  def search
    @items = ItemSearcher.new(query: params[:q]).search
    @items = @items.paginate(page: params[:page], per_page: 10)
    if current_user
      render "search", layout: "application"
    else
      render "search", layout: "before_authentication"
    end
  end

  def mail_check
    @user_token = UserToken.find_by_value(params[:token])
    @user = @user_token.user
    if @user.checked == false
      @user.checked = true
      if @user.save
        session[:current_user_id] = @user.id
        @user.update_column(:logged_at, Time.current)
        flash.notice = "Complete"
        redirect_to [ :edit, current_user ]
      end
    else
      raise NotFound
    end
  end

  def not_found
    raise NotFound
  end

  private
  def user_params
    params.require(:user).permit(
      :screen_name,
      :new_email,
      :password,
      :password_confirmation,
    )
  end
end