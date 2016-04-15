class OrderPart < ActiveRecord::Base

  belongs_to :part
  belongs_to :order 

end