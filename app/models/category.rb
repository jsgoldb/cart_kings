class Category < ActiveRecord::Base
  has_many :parts
  belongs_to :parent, class_name: "Category", foreign_key: "parent_category_id"
  has_many :child_categories, class_name: "Category", foreign_key: "parent_category_id"
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :image
  validates_uniqueness_of :name

  def self.categories_with_parts
    where("id IN (?)", Part.all.pluck(:category_id))
  end

end
