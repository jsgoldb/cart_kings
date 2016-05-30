class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      render :'application/index'
    else
      flash.now[:error] = 'Cannot send message. Please make sure 1. No fields are blank 2. Phone number is in the format 123-456-7890 3. Email is in the format hello@email.com'
      render :new
    end
  end
end