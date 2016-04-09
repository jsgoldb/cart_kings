class CreateCartParts < ActiveRecord::Migration
  def change
    create_table :cart_parts do |t|
      t.integer :cart_id
      t.integer :part_id
      t.string :comments
      t.timestamps null: false
    end
  end
end
