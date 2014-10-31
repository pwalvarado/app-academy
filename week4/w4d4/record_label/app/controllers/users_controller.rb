class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

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
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to root_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
