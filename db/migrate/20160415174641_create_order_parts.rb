class CreateOrderParts < ActiveRecord::Migration
  def change
    create_table :order_parts do |t|
      t.integer :order_id
      t.integer :part_id
    end
  end
end
