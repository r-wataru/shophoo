class ItemsController < ApplicationController
  # PUT
  def add_to_cart
    item = Item.listable.find(params[:id])
    unless current_user.managing_organizations.exists?(id: item.organization_id)
      cart = current_user.shopping_cart
      cart ||= current_user.create_shopping_cart
      cart.add_item(item)
      cart.save!
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
end