class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  def current_user
    if session[:current_user_id] && session[:session_token]
      @current_user ||= User.find_by_id(session[:current_user_id])
    end
    @current_user
  end
  helper_method :current_user
end
