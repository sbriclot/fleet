class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.date :date
      t.integer :km
      t.string :invoice_ref
      t.references :invoice_type, null: false, foreign_key: true
      t.text :remarks
      t.float :price
      t.references :vehicle, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
