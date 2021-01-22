class CreateMaintenances < ActiveRecord::Migration[6.0]
  def change
    create_table :maintenances do |t|
      t.date :date
      t.integer :km
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
