class CreateInvoiceTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :invoice_types do |t|
      t.string :type

      t.timestamps
    end
  end
end
