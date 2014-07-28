class ShoppingCartsController < ApplicationController
  def show
    @shopping_cart = current_user.shopping_cart
  end
end