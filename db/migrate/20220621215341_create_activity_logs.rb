class CreateActivityLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :items, null: false, foreign_key: true
      t.references :item_amount, null: false, foreign_key: true

      t.timestamps
    end
  end
end
