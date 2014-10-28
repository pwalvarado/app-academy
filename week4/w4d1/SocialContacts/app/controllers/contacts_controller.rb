class ContactsController < ApplicationController
  def index
    render json: User.find(params[:user_id]).contacts +
      User.find(params[:user_id]).shared_contacts 
  end

  def show
    render json: Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :bad_request
      )
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :bad_request
    end
  end

  def destroy
    @contact = Contact.find_by id: params[:id]
    if @contact
      render json: @contact
      @contact.destroy
    else
      render json: 'No such contact.', status: :unprocessable_entity
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
