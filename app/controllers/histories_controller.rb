class HistoriesController < ApplicationController
  def show
    @histories = current_user.histories
  end
end