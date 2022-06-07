class AddDetailsToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :retail, :decimal
    add_column :items, :category, :string
    add_column :items, :location, :string
  end
end
