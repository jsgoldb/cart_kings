class CartPart < ActiveRecord::Base
  belongs_to :cart
  belongs_to :part
end
