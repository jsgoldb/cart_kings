module ApplicationHelper 

  def is_admin?
    current_user.admin 
  end

  def can_modify_cart?(cart)
    cart.user_id == current_user.id || current_user.admin ? true : false
  end

end