class Manager::BaseController < ApplicationController
  layout "manager"
  before_filter :prepare_organization
  
  private
  def prepare_organization
    if params[:orgaization_id]
      @organizatinon = current_user.managing_organizations.find(params[:organization_id])
    end
  end
end