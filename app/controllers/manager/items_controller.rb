class Manager::ItemsController < Manager::BaseController
  def index
    @items = @organization.items.active.paginate(page: params[:page], per_page: 10)
  end

  def show
    @item = @organization.items.find(params[:id])
  end

  def edit
    @item = @organization.items.find(params[:id])
    @item.build_image unless @item.image
  end

  def update
    @item = @organization.items.find(params[:id])
    @item.assign_attributes edit_item_params
    if params[:uploaded_image1_destroy].present?
      d = @item.image
      d.data1 = nil
      d.data1_content_type = nil
      d.save
    end
    if params[:uploaded_image2_destroy].present?
      d = @item.image
      d.data2 = nil
      d.data2_content_type = nil
      d.save
    end
    if params[:uploaded_image3_destroy].present?
      d = @item.image
      d.data3 = nil
      d.data3_content_type = nil
      d.save
    end
    if @item.valid?
      @item.save
      flash.notice = "Complete"
      redirect_to [ :manager, @organization, :items ]
    else
      @item.build_image unless @image.image
      flash.now.alert = "Invalid!"
      render action: :edit
    end
  end

  def destroy
    @item = @organization.items.find(params[:id])
    @item.update_column(:deleted_at, Time.current)
    redirect_to [ :manager, @organization, :items ]
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

  def edit_item_params
    params.require(:item).permit(
      :price, :listable, :code_name,
      :display_name, :description,
      image_attributes: [
        'uploaded_image1',
        'data1_content_type',
        'uploaded_image2',
        'data2_content_type',
        'uploaded_image3',
        'data3_content_type',
        'id'
      ]
    )
  end
end