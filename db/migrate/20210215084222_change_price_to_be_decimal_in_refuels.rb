class ChangePriceToBeDecimalInRefuels < ActiveRecord::Migration[6.0]
  def change

    # Allows for up to 3 numbers before the comma and 2 decimals
    # Example: 300,25€
    def up
      change_column :refuels, :price, :decimal, precision: 5, scale: 2
    end

    # Allows to rollback
    def down
      change_column :refuels, :price, :float
    end
  end
end
