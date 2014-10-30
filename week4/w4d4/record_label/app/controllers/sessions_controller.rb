class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)
    redirect_to user_url(@user)
  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
