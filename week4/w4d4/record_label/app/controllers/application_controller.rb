class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :require_login

  def logged_in?
    !current_user.nil?
  end

  def log_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  private
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to view this page"
      redirect_to new_session_url
    end
  end

end
