class ChangeQuantityToBeDecimalInRefuels < ActiveRecord::Migration[6.0]
  def change

    # Allows for up to 3 numbers before the comma and 2 decimals
    # Example: 150,25 liters
    def up
      change_column :refuels, :quantity, :decimal, precision: 5, scale: 2
    end

    # Allows to rollback
    def down
      change_column :refuels, :quantity, :float
    end
  end
end
