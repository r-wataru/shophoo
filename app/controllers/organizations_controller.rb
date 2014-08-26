class OrganizationsController < ApplicationController
  def new
    @organization = current_user.organizations.new
    @organization.build_organization_address unless @organization.organization_address
    @organization.build_image unless @organization.image
  end

  def create
    @organization = current_user.organizations.new organization_params
    @organization.build_organization_address unless @organization.organization_address
    @organization.build_image unless @organization.image
    if @organization.save
      @organization.managers << current_user
      owner = @organization.manager_roles.first
      owner.owner = true
      owner.save
      flash.notice = t(".complete")
      redirect_to [ :manager, @organization ]
    else
      flash.now.alert = t(".invalid")
      render action: :new
    end
  end

  private
  def organization_params
    params.require(:organization).permit(
      :real_name,
      :screen_name,
      image_attributes: [
        'uploaded_image',
        'content_type'
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
        'fax3'
      ]
    )
  end
end