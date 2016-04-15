class OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :is_admin?, only: [:index, :destroy]

  def index
    @orders = Order.order(created_at: :desc).where.not(user_id: nil)
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
  end

end