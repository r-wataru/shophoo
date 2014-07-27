class TopController < ApplicationController
  def index
    if current_user
      render "index", layout: "application"
    else
      render "index", layout: "before_authentication"
    end
  end
  
  def search
    @items = ItemSearcher.new(query: params[:q]).search
    @items = @items.paginate(page: params[:page], per_page: 10)
    if current_user
      render "search", layout: "application"
    else
      render "search", layout: "before_authentication"
    end
  end
end