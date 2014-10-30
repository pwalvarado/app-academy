class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.create!(user_params)
    login!(@user)
    redirect_to user_url(@user)
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
