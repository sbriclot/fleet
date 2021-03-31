class ChangePriceToBeDecimalInInvoices < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      # Allows for up to 5 numbers before the comma and 2 decimals
      # Example: 10250€,25
      dir.up do

        execute <<-SQL
        UPDATE invoices SET price = ROUND(price::numeric,2)
        SQL

        change_column :invoices, :price, :decimal, precision: 7, scale: 2
      end

      # Allows to rollback
      dir.down do
        change_column :invoices, :price, :float
      end
    end
  end
end
