class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :name, null: false
      t.integer :bearer_id, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :stocks, :name, unique: true
  end
end
