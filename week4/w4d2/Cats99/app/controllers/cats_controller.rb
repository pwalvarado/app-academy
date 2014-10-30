class CatsController < ApplicationController
  before_action :ensure_logged_in, :except => [:index, :show]
  
  def index
    @cats = Cat.all
    render :index 
  end
  
  def show
    @cat = Cat.find(params[:id])
    @rental_requests = CatRentalRequest.where("cat_id =               #{@cat.id}").order(:start_date)
        
    render :show
  end
  
  def new
    @cat = Cat.new
    render :new
  end
  
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
    unless @cat.owner.id == current_user.id
      flash[:errors] ||= []
      flash[:errors] << "You can only edit your own cats."
      redirect_to cats_url
    end
  end
  
  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end
  
  private
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :sex, :color, :description)
  end
end
