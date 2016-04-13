class CartPartsController < ApplicationController

  def index
  end

  def new
    @cart_part = CartPart.new
    @cart = Cart.find(params[:id])
  end

  def add_to_my_cart
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
    flash[:notice] = "Item added to My Cart"
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end

  def create
    @part = Part.find_by(description: params[:cart_part][:part])
    @cart = Cart.find(params[:cart_id])
    @cart_part = CartPart.find_by(part_id: @part.id, cart_id: @cart.id)
    if !@cart_part
      @cart_part = @cart.cart_parts.create(part_id: @part.id, cart_id: @cart.id)
    end
    @cart_part.save
    flash[:notice] = "Part added to Cart"
    redirect_to cart_path(@cart)
  end

  def edit
    @cart_part = CartPart.find(params[:id])
  end

  def update
    @cart_part = CartPart.find(params[:id])
    @cart_part.update(cart_part_params)
    flash[:notice] = "Comment Updated."
    redirect_to my_cart_path
  end

  def show
  end

  def destroy
    @cart_part = CartPart.find(params[:id])
    @cart_part.destroy
    flash[:notice] = "Item removed from Cart"
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end

  private

    def cart_part_params
      params.require(:cart_part).permit(:cart_id, :part_id, :comments, :part_description, :cart_id)
    end

end
