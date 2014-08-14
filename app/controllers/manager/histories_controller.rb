class Manager::HistoriesController < Manager::BaseController
  def index
    @histories = @organization.histories.paginate(page: params[:page], per_page: 10)
  end

  def show
    @history = @organization.histories.find(params[:id])
  end
end