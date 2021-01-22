class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.string :task
      t.integer :creation_km
      t.integer :limit_km
      t.date :limit_date
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
