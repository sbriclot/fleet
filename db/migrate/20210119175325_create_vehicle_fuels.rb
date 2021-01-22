class CreateVehicleFuels < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicle_fuels do |t|
      t.references :fuel, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
