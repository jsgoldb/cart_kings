class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_parts
  has_many :parts, through: :cart_parts
  has_attached_file :image, styles: { medium: "500x500>", thumb: "100x100>" }, default_url: "/images/:style/missing.png",
  :source_file_options => { :all => '-auto-orient' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  #validates_attachment_presence :image

  #cart.image = File.open("#{Rails.root}/public/system/carts/images/cart1.jpg")
end
