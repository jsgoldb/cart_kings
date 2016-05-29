class CartsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_admin?, only: [:new, :edit]
  
  def index
    @carts = Cart.where.not(image_file_name: nil)
    if current_user
      gon.watch.logged_in = 'true'
      if current_user.admin
        gon.watch.admin = 'true'
      else
        gon.watch.admin = 'false'
      end
    else
      gon.watch.logged_in = 'false'
    end
    respond_to do |f|
      f.html { render :index}
      f.json { render json: @carts}
    end
  end

  def new 
    @cart = current_user.carts.new

    if current_user
      gon.watch.logged_in = 'true'
      if current_user.admin
        gon.watch.admin = 'true'
      else
        gon.watch.admin = 'false'
      end
    else
      gon.watch.logged_in = 'false'
    end

  end

  def create
    @cart = Cart.create(cart_params)
    @cart.user_id = User.find(params[:cart][:user_id])
    @cart.save
    flash.now[:notice] = "Cart successfully created."
    cartClone = @cart #handles remotipart calling action twice
    if @cart.image_file_name = nil
      @cart.destroy
    end
    render cart_path(@cart)
  end

  def edit
    @cart = Cart.find(params[:id])

    if current_user
      gon.watch.logged_in = 'true'
      if current_user.admin
        gon.watch.admin = 'true'
      else
        gon.watch.admin = 'false'
      end
    else
      gon.watch.logged_in = 'false'
    end

  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    return head(:forbidden) if !can_modify_cart?(@cart)
    flash.now[:notice] = "Cart successfully updated."
    render cart_path(@cart)
  end

  def show
    if current_user
      gon.watch.logged_in = 'true'
      if current_user.admin
        gon.watch.admin = 'true'
      else
        gon.watch.admin = 'false'
      end
    else
      gon.watch.logged_in = 'false'
    end
    @cart = Cart.find(params[:id])
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @cart }
    end
  end

  def show_my_cart
    @cart = current_user.current_cart
    render :'mycart'
  end

  def destroy
    @cart = Cart.find(params[:id])
    return head(:forbidden) if !can_modify_cart?(@cart)
    @cart.destroy
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
    #create new order to store for admin records 
    @order = Order.create(user_id: current_user.id)
    @cart.parts.each do |part| 
      @order_part = OrderPart.create(part_id: part.id, order_id: @order.id)
      @order_part.save
    end
    @order.save
    render :'application/index'
  end

  private

    def cart_params
      params.require(:cart).permit(:comments, :price, :image, :user_id)
    end

end
