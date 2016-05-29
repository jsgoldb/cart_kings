class Part < ActiveRecord::Base
  has_many :cart_parts
  has_many :carts, through: :cart_parts
  belongs_to :category
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png", :s3_protocol => :https
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :image
  validates_uniqueness_of :description
  has_many :order_parts
  has_many :orders, through: :order_parts

  def category_name=(name)
    self.category = Category.find_or_create_by(name: name)
  end

end
