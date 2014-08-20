class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user

  class Forbidden < StandardError; end
  class NotFound < StandardError; end
  class BadRequest < StandardError; end

  private
  def current_user
    if session[:current_user_id]
      @current_user ||= User.find_by_id(session[:current_user_id])
    end
    @current_user
  end
  helper_method :current_user

  def authenticate_user
    raise Forbidden unless current_user
  end

  rescue_from BadRequest, with: :rescue_400
  rescue_from Forbidden, with: :rescue_403
  rescue_from NotFound, with: :rescue_404
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_404
  rescue_from ActionController::RoutingError, with: :rescue_404
  rescue_from StandardError, with: :rescue_500 unless Rails.env.test?

  def render_error(template, status)
    if request.xhr?
      render nothing: true, status: status
    else
      render "errors/#{template}", status: status, layout: "before_authentication"
    end
  end

  def rescue_400(exception)
    render text: "Bad Request", status: 400
  end

  def rescue_403(exception)
    if request.xhr?
      render_error "forbidden", 403
    elsif request.get? && !@current_user
      @from = request.url
      @error_title = "ログインが必要です。"
      render template: 'sessions/new',
        layout: "before_authentication"
    else
      render_error "forbidden", 403
    end
  end

  def rescue_404(exception)
    render_error "not_found", 404
  end

  def rescue_500(exception)
    @exception = exception
    render_error "internal_server_error", 500
  end
end
