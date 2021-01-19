class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :brand
      t.string :model
      t.string :registration
      t.string :sn
      t.integer :tank_capacity
      t.integer :actual_km
      t.float :total_expenses
      t.date :purchase_date
      t.integer :purchase_km
      t.date :sale_date
      t.integer :sale_km
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
