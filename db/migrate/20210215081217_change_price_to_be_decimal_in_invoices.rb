class ChangePriceToBeDecimalInInvoices < ActiveRecord::Migration[6.0]
  def change
   # Allows for up to 4 numbers before the comma and 2 decimals
   # Example: 1250€,25
    def up
      change_column :invoices, :price, :decimal, precision: 6, scale: 2
    end
    # Allows to rollback
    def down
      change_column :invoices, :price, :float
    end
  end
end
