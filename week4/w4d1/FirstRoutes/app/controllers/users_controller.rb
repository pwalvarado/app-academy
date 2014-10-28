class UsersController < ApplicationController
  def index
    render json: User.all
  end
  
  def show
    render json: User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render(
        json: @user.errors.full_messages, status: :bad_request
      )
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages, status: :bad_request
    end
  end
  
  def destroy
    @user = User.find_by id: params[:id]
    if @user
      render json: @user
      @user.destroy
    else
      render json: 'No such user.', status: :unprocessable_entity
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username)
  end
end
