class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :cat_owner?
  
  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def cat_owner?
    @cat.owner.id == current_user.id
  end
  
  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end
  
  def logged_in?
    current_user && session[:session_token] == current_user.session_token
  end
  
  def ensure_logged_in
    redirect_to new_session_url if !logged_in?    
  end
end