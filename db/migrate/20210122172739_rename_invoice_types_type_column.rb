class RenameInvoiceTypesTypeColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :invoice_types, :type, :name
  end
end
