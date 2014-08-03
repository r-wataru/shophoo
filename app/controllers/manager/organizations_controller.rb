class Manager::OrganizationsController < Manager::BaseController
  skip_before_filter :prepare_organization
  
  def show
    @organization = current_user.managing_organizations.find(params[:id])
  end
end