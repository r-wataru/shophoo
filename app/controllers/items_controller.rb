class ItemsController < ApplicationController
  skip_before_filter :authenticate_user, only: [ :thumbnail, :data1, :data2, :data3 ]

  # PUT
  def add_to_cart
    item = Item.listable.find(params[:id])
    unless current_user.managing_organizations.exists?(id: item.organization_id)
      cart = current_user.shopping_cart
      cart ||= current_user.create_shopping_cart
      cart.add_item(item)
      cart.save!
      bookmark = current_user.bookmark_folder
      bookmark ||= current_user.create_bookmark_folder
      bookmark.remove_item(item)
      bookmark.save!
    end
    redirect_to :back
  end

  # PUT
  def remove_from_cart
    item = Item.listable.find(params[:id])
    cart = current_user.shopping_cart
    cart ||= current_user.create_shopping_cart
    cart.remove_item(item)
    cart.save!
    redirect_to :back
  end

  # PUT
  def add_to_bookmark
    item = Item.listable.find(params[:id])
    unless current_user.managing_organizations.exists?(id: item.organization_id)
      cart = current_user.bookmark_folder
      cart ||= current_user.create_bookmark_folder
      cart.add_item(item)
      cart.save!
    end
    redirect_to :back
  end

  # PUT
  def remove_from_bookmark
    item = Item.listable.find(params[:id])
    bookmark_folder = current_user.bookmark_folder
    bookmark_folder ||= current_user.create_bookmark_folder
    bookmark_folder.remove_item(item)
    bookmark_folder.save!
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