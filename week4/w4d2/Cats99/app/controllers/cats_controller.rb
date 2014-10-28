class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index 
  end
  
  def show
    @cat = Cat.find(params[:id])
    render :show
  end
  
  def new
    render :new
  end
  
  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
    
  end
  
  private
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :sex, :color, :description)
  end
end
