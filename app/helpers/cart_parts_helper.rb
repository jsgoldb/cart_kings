module CartPartsHelper

  def current_part(part)
    CartPart.find_by(cart_id: @cart.id, part_id: part.id)
  end

end
