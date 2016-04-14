class AddContactTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact_time, :string
  end
end
