class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :brand
      t.string :barcode
      t.string :secondary_barcode
      t.text :description

      t.timestamps
    end
  end
end
