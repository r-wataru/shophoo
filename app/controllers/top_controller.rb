class TopController < ApplicationController
  def index
    if current_user
      render "index", layout: "application"
    else
      @user = User.new
      render "index", layout: "before_authentication"
    end
  end

  def create
    if request.post?
      @user = User.new user_params
      @user.setting_password = true
      if @user.save
        @user.send_token
        @user.emails << Email.new(address: @user.new_emails.last.address, main: true)
        redirect_to action: :thanks
      else
        render action: :index
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