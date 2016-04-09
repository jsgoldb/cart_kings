class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :description
      t.integer :category_id
      t.timestamps null: false
    end
  end
end
