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

  # GET
  def thumbnail
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
      format.png { send_thumbnail_data }
      format.jpeg { send_thumbnail_data }
      format.gif { send_thumbnail_data }
    end
  end

  private
  def send_thumbnail_data
    send_data(@item.image.thumbnail_data,
      :disposition => "inline",
      :type => @item.image.thumbnail_content_type)
  end
end