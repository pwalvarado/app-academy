class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = "Incorrect username/password combination"
      render :new
    end
  end
  
  def destroy
    user = current_user
    user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
