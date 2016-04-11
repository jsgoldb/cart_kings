class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @categories = Category.all
    @cart = Cart.find(4)
  end

  # def after_sign_in_path_for(resource)
  #   request.env['omniauth.origin'] || root_path
  # end

  def after_sign_in_path_for(resource)
    root_path
  end



end
