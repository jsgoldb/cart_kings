class CartPartsController < ApplicationController

  def index
  end

  def new
  end

  def create
    @user = current_user
    if @user.current_cart
      @cart = @user.current_cart
    else
      @cart = @user.carts.create
    end
    @cart_part = CartPart.find_by(part_id: params[:part_id], cart_id: @cart)
    if !@cart_part
      @cart_part = @cart.cart_parts.create(part_id: params[:part_id], cart_id: @cart)
    end
    @cart_part.save
    @user.current_cart = @cart
    @user.save
    redirect_to cart_path(@cart)
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy

  end

end
