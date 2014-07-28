class ShoppingCartsController < ApplicationController
  def show
    @shopping_cart = current_user.shopping_cart
  end
  
  # PUT
  def checkout
    @shopping_cart = current_user.shopping_cart
    if @shopping_cart.present?
      @shopping_cart.checkout
    end
    redirect_to :back
  end
end