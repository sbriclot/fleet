class ChangePriceToBeDecimalInRefuels < ActiveRecord::Migration[6.0]
  def change

    reversible do |dir|
      # Allows for up to 3 numbers before the comma and 2 decimals
      # Example: 300,25€
      dir.up do
        change_column :refuels, :price, :decimal, precision: 5, scale: 2
      end

      # Allows to rollback
      dir.down do
        change_column :refuels, :price, :float
      end
    end
  end
end
