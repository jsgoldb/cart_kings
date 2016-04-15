class Order < ActiveRecord::Base

  has_many :order_parts
  has_many :parts, through: :order_parts
  belongs_to :user

end
