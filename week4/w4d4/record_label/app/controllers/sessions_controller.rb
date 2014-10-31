class SessionsController < ApplicationController
  skip_before_action :require_login, except: :destroy

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      log_in!(@user)
      redirect_to root_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << 'Invalid username/password combination.'
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
