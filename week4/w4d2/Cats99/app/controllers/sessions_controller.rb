class SessionsController < ApplicationController

  before_action :ensure_logged_in, except: [:new, :create]
  
  def new
    if logged_in?
      redirect_to cats_url
    else
      @user = User.new
      render :new
    end
  end
  
  def create
    @user = User.find_by_credentials(
      user_params[:user_name],
      user_params[:password]
    )
    if @user
      @user.reset_session_token!
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << "something wrong in session"
      @user = User.new(user_params)
      render :new
    end
  end
  
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
  
  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
