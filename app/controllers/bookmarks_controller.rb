class BookmarksController < ApplicationController
  def show
    @bookmark = current_user.bookmark_folder
  end
end