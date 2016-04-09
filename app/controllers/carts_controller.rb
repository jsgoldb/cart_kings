class CartsController < ApplicationController
  
  def index
    @carts = Cart.where.not(image_file_name: nil)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  #cart.image = File.open("#{Rails.root}/public/system/carts/images/cart29.jpg")

end
