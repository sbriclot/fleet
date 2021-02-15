class ChangeKmToBeDecimalInRefuels < ActiveRecord::Migration[6.0]
  def change
    # Allows for up to 4 numbers before the comma and 1 decimals
    # Example : 1000,5km.
    def up
      change_column :refuels, :km, :decimal, precision:5, scale: 1
    end

    # Allows to rollback
    def down
      change_column :refuels, :km, :float
    end
  end
end