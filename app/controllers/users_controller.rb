class UsersController < ApplicationController
  skip_before_filter :authenticate_user, only: [ :thumbnail, :data ]

  def edit
    current_user.build_image unless current_user.image
  end

  def update
    current_user.build_image unless current_user.image
    d = current_user.image
    if params[:uploaded_image_destroy].present?
      d.data = nil
      d.thumbnail_data = nil
      d.content_type = nil
      d.thumbnail_content_type = nil
    end
    if current_user.update_attributes user_params
      d.save
      flash.notice = t(".complete")
      redirect_to current_user
    else
      flash.now.alert = t(".invalid")
      render action: :edit
    end
  end

  def edit_password
  end

  def update_password
    current_user.setting_password = true
    if current_user.update_attributes params.require(:user).permit(:password, :password_confirmation)
      flash.notice = t(".complete")
      redirect_to current_user
    else
      flash.now.alert = t(".invalid")
      render action: :edit_password
    end
  end

  def new_email
    @email = current_user.new_emails.new
  end

  def create_email
    @email = current_user.new_emails.new params.require(:new_email).permit(:address)
    if @email.valid?
      if @email.save
        @email.send_mail
        redirect_to current_user,
        notice: @email.address + t(".to_send")
      else
        flash.now.alert = t(".invalid")
        render action: :new_email
      end
    else
      flash.now.alert = t(".invalid")
      render action: :new_email
    end
  end

  def add_emails
    @user_token = UserToken.find_by_value(params[:token])
    if @user_token.blank?
      raise NotFound
    else
      @user = @user_token.user
      if @user.new_emails.last.address.present?
        @user.emails << Email.new(address: @user.new_emails.last.address)
        @user.new_emails.last.destroy
        @user_token.destroy
        flash.notice = t(".complete_email")
        redirect_to current_user
      else
        flash.notice = t(".complete")
        redirect_to current_user
      end
    end
  end

  def destroy_email
    @email = current_user.emails.find(params[:id])
    redirect_to :back
  end

  # GET
  def thumbnail
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html
      format.png { send_thumbnail_data }
      format.jpeg { send_thumbnail_data }
      format.gif { send_thumbnail_data }
    end
  end

  # GET
  def data
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html
      format.png { send_data_data }
      format.jpeg { send_data_data }
      format.gif { send_data_data }
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :real_name,
      :screen_name,
      :birthday,
      :sex,
      image_attributes: [
        'uploaded_image',
        'content_type',
        'id'
      ],
      work_address_attributes: [
        'company_name',
        'about',
        'country_code',
        'zip_code',
        'state',
        'city',
        'address1',
        'address2',
        'phone',
        'phone1',
        'phone2',
        'phone3',
        'mobile',
        'mobile1',
        'mobile2',
        'mobile3',
        'fax',
        'fax1',
        'fax2',
        'fax3',
        'id'
      ],
      private_address_attributes: [
        'country_code',
        'zip_code',
        'state',
        'city',
        'address1',
        'address2',
        'phone',
        'phone1',
        'phone2',
        'phone3',
        'mobile',
        'mobile1',
        'mobile2',
        'mobile3',
        'fax',
        'fax1',
        'fax2',
        'fax3',
        'id'
      ]
    )
  end

  def send_thumbnail_data
    send_data(@user.image.thumbnail_data,
      :disposition => "inline",
      :type => @user.image.thumbnail_content_type)
  end

  def send_data_data
    send_data(@user.image.data,
      :disposition => "inline",
      :type => @user.image.content_type)
  end
end