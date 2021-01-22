class CreateMaintenancePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :maintenance_plans do |t|
      t.text :task
      t.text :details
      t.integer :interval_km
      t.integer :interval_months
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
