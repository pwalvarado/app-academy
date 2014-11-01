class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def login!(user)
    return nil if user.nil?
    session[:session_token] = user.session_token
  end
  
  def current_user
    User.find_by(session_token: session[:session_token])
  end
  
  def logged_in?
    !!current_user
  end

end
