class Manager::ItemsController < Manager::BaseController
  def index
    @items = @organization.items.paginate(page: params[:page], per_page: 10)
  end
  
  def edit
    @item = @organization.items.find(params[:id])
  end
  
  def update
    @item = @organization.items.find(params[:id])
    redirect_to :back
  end
end