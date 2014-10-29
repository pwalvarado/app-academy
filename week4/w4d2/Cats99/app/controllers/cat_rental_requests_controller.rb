class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    render :new
  end
  
  def create
    @cat_rental_request = CatRentalRequest.new(request_params)
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
    request.approve!
    redirect_to cat_url(request.cat)
  end
  
  def deny
    request = CatRentalRequest.find(params[:id])
    request.deny!
    p request.cat
    redirect_to cat_url(request.cat)
  end
  
  private
  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
