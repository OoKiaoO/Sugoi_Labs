class CreateActivityLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.text :action
      t.text :item_amount
      t.date :item_amount_exp_date

      t.timestamps
    end
  end
end
