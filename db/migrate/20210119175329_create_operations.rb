class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.text :task
      t.text :details
      t.references :maintenance, null: false, foreign_key: true
      t.references :maintenance_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
