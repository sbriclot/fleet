class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.text :address
      t.string :tel
      t.string :home_url
      t.string :booking_url

      t.timestamps
    end
  end
end
