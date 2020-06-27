class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :warehouse_id
      t.decimal :total_value, precision: 8, scale: 2, default: "0.0"
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
