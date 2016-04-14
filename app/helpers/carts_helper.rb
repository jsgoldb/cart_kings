module CartsHelper

  def dont_rotate(cart)
    cart.image_file_name == "cart2.jpg" || cart.image_file_name == "cart7.jpg" || cart.image_file_name == "cart27.jpg"
  end

  def add_info_or_submit
    if flash[:notice] && flash[:notice].include?("Thank you for entering your contact information.")
      return "submit"
    else
      return "add info"
    end
  end


end
