class Manager::OrganizationsController < Manager::BaseController
  def show
    @organization = current_user.managing_organizations.find(params[:id])
  end
end