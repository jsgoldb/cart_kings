class CartsController < ApplicationController
  
  def index
    @carts = Cart.where.not(image_file_name: nil)
  end

  def new
    @cart = current_user.carts.new
  end

  def create
    @cart = Cart.create(cart_params)
    @cart.user_id = User.find(params[:cart][:user_id])
    @cart.save
    flash[:notice] = "Cart successfully created."
    if !@cart.errors.empty?
      raise @cart.errors.inspect
    end
    redirect_to cart_path(@cart)
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    flash[:notice] = "Cart successfully updated."
    redirect_to cart_path(@cart)
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def show_my_cart
    @cart = current_user.current_cart
    render :'mycart'
  end

  def destroy
    @cart = Cart.find(params[:id])
    flash[:notice] = "Cart Deleted."
    redirect_to carts_path
  end

  def my_cart_checkout
    @cart = Cart.find(current_user.current_cart)
    @user = current_user
    @user.current_cart = nil
    @user.save
    @quote = CartMailer.quote_email(@user, @cart)
    @quote.deliver_now
    if @quote.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
    else
      flash.now[:error] = 'Cannot send message.'
      render cart_path(@cart)
    end
    render :'application/index'
  end

  #cart.image = File.open("#{Rails.root}/public/system/carts/images/cart29.jpg")
  private

    def cart_params
      params.require(:cart).permit(:comments, :price, :image, :user_id)
    end

end
