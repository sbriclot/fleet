class CreateDocumentations < ActiveRecord::Migration[6.0]
  def change
    create_table :documentations do |t|
      t.string :name
      t.string :doc_type
      t.string :path
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
