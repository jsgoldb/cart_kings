class CartSerializer < ActiveModel::Serializer
  attributes :id, :comments, :user_id, :image, :price, :image_medium, :image_thumb
  
  has_many :parts

  def image_medium
    object.image.url(:medium)
  end

  def image_thumb
    object.image.url(:thumb)
  end

end
