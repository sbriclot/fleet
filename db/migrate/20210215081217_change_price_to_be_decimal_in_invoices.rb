class ChangePriceToBeDecimalInInvoices < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      # Allows for up to 4 numbers before the comma and 2 decimals
      # Example: 1250€,25
      dir.up do
        # execute <<-SQL
        # SELECT TRUNC(price ,2) FROM refuels;
        # SQL

        change_column :invoices, :price, :decimal, precision: 6, scale: 2
      end

      # Allows to rollback
      dir.down do
        change_column :invoices, :price, :float
      end
    end
  end
end
