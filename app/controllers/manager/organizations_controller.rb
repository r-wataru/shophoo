class Manager::OrganizationsController < Manager::BaseController
  skip_before_filter :prepare_organization
  
  def show
    @organization = current_user.managing_organizations.find(params[:id])
  end
  
  def edit
    @organization = current_user.managing_organizations.find(params[:id])
  end
  
  def update
    @organization = current_user.managing_organizations.find(params[:id])
    if @organization.update_attributes
    else
    end
  end
  
  private
  def organization_params    
  end
end