class AddClosedToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :closed, :boolean, default: false
  end
end
