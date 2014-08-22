class HistoriesController < ApplicationController
  def index
    @histories = current_user.histories
  end

  def show
    @history = current_user.histories.find(params[:id])
  end
end