class ChangeQuantityToBeDecimalInRefuels < ActiveRecord::Migration[6.0]
  def change

    reversible do |dir|
      # Allows for up to 3 numbers before the comma and 2 decimals
      # Example: 150,25 liters
      dir.up do
        execute <<-SQL
        SELECT TRUNC(quantity ,2) FROM refuels;
        SQL

        change_column :refuels, :quantity, :decimal, precision: 5, scale: 2
      end

      # Allows to rollback
      dir.down do
        change_column :refuels, :quantity, :float
      end
    end
  end
end
