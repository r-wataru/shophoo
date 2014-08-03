class Manager::ItemsController < Manager::BaseController
  def index
    @organization = current_user.managing_organizations.find(params[:organization_id])
    @items = @organization.items.paginate(page: params[:page], per_page: 10)
  end
end