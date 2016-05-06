class PartSerializer < ActiveModel::Serializer
  attributes :id, :description, :category_id, :image, :price, :image_thumb, :image_medium

  def image_medium
    object.image.url(:medium)
  end

  def image_thumb
    object.image.url(:thumb)
  end

end
