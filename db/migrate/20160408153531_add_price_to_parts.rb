class AddPriceToParts < ActiveRecord::Migration
  def change
    add_column :parts, :price, :decimal, :precision => 8, :scale => 2
  end
end
