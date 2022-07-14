class AddCheckedToItemAmounts < ActiveRecord::Migration[6.1]
  def change
    add_column :item_amounts, :checked, :boolean, default: false
    add_column :item_amounts, :exp_amount, :integer
  end
end
