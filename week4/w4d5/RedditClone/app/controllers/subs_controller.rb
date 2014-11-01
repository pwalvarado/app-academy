class SubsController < ApplicationController
  before_action :ensure_logged_in, except: :show
  before_action :ensure_sub_moderator, only: [:edit, :update]
  
  def new
    @sub = Sub.new
    render :new
  end
  
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] ||= []
      flash[:errors] += @sub.errors.full_messages
      render :new
    end
  end
  
  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end
  
  def update
    @sub = Sub.find(params[:id])
    
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] ||= []
      flash[:errors] += @sub.errors.full_messages
      render :edit
    end
  end
  
  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
  private
  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end
  
  def ensure_sub_moderator
    sub = Sub.find(params[:id])
    if current_user.id != sub.moderator_id
      redirect_to sub_url(sub)
    end
  end
end
