class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index

  end

  # def after_sign_in_path_for(resource)
  #   request.env['omniauth.origin'] || root_path
  # end

  def after_sign_in_path_for(resource)
    root_path
  end

  def is_admin?
    unless current_user.admin
      head(:forbidden)
    end 
  end

  def can_modify_cart?(cart)
    if cart.user_id == current_user.id || current_user.admin
      return true
    else
      return false
    end
  end





end
