class Manager::BaseController < ApplicationController
  layout "manager"
  before_filter :prepare_organization
  
  private
  def prepare_organization
    @organization = current_user.managing_organizations.find(params[:organization_id])
  end
end