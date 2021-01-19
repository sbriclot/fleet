class CreateRefuels < ActiveRecord::Migration[6.0]
  def change
    create_table :refuels do |t|
      t.date :date
      t.float :km
      t.float :quantity
      t.float :price
      t.references :fuel, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
