class Manager::ItemsController < Manager::BaseController
  def index
    @items = @organization.items.paginate(page: params[:page], per_page: 10)
  end

  def show
    @item = @organization.items.find(params[:id])
  end

  def edit
    @item = @organization.items.find(params[:id])
  end

  def update
    @item = @organization.items.find(params[:id])
    redirect_to :back
  end

  def destroy
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

def data1
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
      format.png { send_data1_data }
      format.jpeg { send_data1_data }
      format.gif { send_data1_data }
    end
  end

  def data2
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
      format.png { send_data2_data }
      format.jpeg { send_data2_data }
      format.gif { send_data2_data }
    end
  end

  def data3
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
      format.png { send_data3_data }
      format.jpeg { send_data3_data }
      format.gif { send_data3_data }
    end
  end

  private
  def send_thumbnail_data
    send_data(@item.image.thumbnail_data,
      :disposition => "inline",
      :type => @item.image.thumbnail_content_type)
  end

  def send_data1_data
    send_data(@item.image.data1,
      :disposition => "inline",
      :type => @item.image.data1_content_type)
  end

  def send_data2_data
    send_data(@item.image.data2,
      :disposition => "inline",
      :type => @item.image.data2_content_type)
  end

  def send_data3_data
    send_data(@item.image.data3,
      :disposition => "inline",
      :type => @item.image.data3_content_type)
  end
end