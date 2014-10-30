class CatRentalRequestsController < ApplicationController
  before_action :ensure_logged_in
  
  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    render :new
  end
  
  def create
    @cat_rental_request = CatRentalRequest.new(request_params)
    @cat_rental_request.requester_id = current_user.id
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat)
    else
      @cats = Cat.all
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end
  
  def approve
    request = CatRentalRequest.find(params[:id])
    if request.cat.owner.id == current_user.id
      request.approve!
      redirect_to cat_url(request.cat)
    else
      redirect_to cats_url 
    end
  end
  
  def deny
    request = CatRentalRequest.find(params[:id])
    if  request.cat.owner.id == current_user.id
      request.deny!
      redirect_to cat_url(request.cat)
    else
      redirect_to cats_url 
    end
  end
  
  private
  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
