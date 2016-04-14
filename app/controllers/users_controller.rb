class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :is_admin?, only: [:index, :show]

  def index
  end

  def show
  end

  def edit
    @user = current_user
    render 'carts/add_user_info'
  end

  def update
    @user = current_user
    @user.update(user_params)
    if @user.save
      flash[:notice] = "Thank you for entering your contact information. Click 
      Get Quote to send your request now."
      redirect_to my_cart_path
    else
      flash[:error] = "Please enter a valid Phone Number."
      redirect_to add_info_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :phone, :contact_time, :contact_email)
    end

end