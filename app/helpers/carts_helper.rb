module CartsHelper

  def dont_rotate(cart)
    cart.image_file_name == "cart2.jpg" || cart.image_file_name == "cart7.jpg" || cart.image_file_name == "cart27.jpg"
  end



end
