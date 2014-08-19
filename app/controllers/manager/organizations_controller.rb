class Manager::OrganizationsController < Manager::BaseController
  skip_before_filter :prepare_organization
  
  def show
    @organization = current_user.managing_organizations.find(params[:id])
  end
  
  def edit
    @organization = current_user.managing_organizations.find(params[:id])
    @organization.build_organization_address unless @organization.organization_address
    @organization.build_image unless @organization.image
  end
  
  def update
    @organization = current_user.managing_organizations.find(params[:id])
    @organization.build_organization_address unless @organization.organization_address
    d = @organization.image
    if params[:uploaded_image_destroy].present?
      d.data = nil
      d.thumbnail_data = nil
      d.content_type = nil
      d.thumbnail_content_type = nil
    end
    if @organization.update_attributes organization_params
      d.save if params[:uploaded_image_destroy].present?
      flash.notice = "Complete"
      redirect_to [ :manager, @organization ]
    else
      flash.now.alert = "Invalid"
      render action: :edit
    end
  end
  
# GET
  def thumbnail
    @organization = current_user.managing_organizations.find(params[:organization_id])
    respond_to do |format|
      format.html
      format.png { send_thumbnail_data }
      format.jpeg { send_thumbnail_data }
      format.gif { send_thumbnail_data }
    end
  end

  def data
    @organization = current_user.managing_organizations.find(params[:organization_id])
    respond_to do |format|
      format.html
      format.png { send_data_data }
      format.jpeg { send_data_data }
      format.gif { send_data_data }
    end
  end
  
  private
  def organization_params
    params.require(:organization).permit(
      :real_name,
      :screen_name,
      image_attributes: [
        'uploaded_image',
        'content_type',
        'id'
      ],  
      organization_address_attributes: [
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
    send_data(@organization.image.thumbnail_data,
      :disposition => "inline",
      :type => @organization.image.thumbnail_content_type)
  end

  def send_data_data
    send_data(@organization.image.data,
      :disposition => "inline",
      :type => @organization.image.content_type)
  end
end