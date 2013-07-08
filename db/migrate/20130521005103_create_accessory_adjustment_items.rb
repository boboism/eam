class CreateAccessoryAdjustmentItems < ActiveRecord::Migration
  def change
    create_table :accessory_adjustment_items do |t|
      t.string :name
      t.string :model
      t.string :specification
      t.string :serial_no
      t.string :brand
      t.string :store_location
      t.decimal :amount
      t.string :type
      t.integer :accessory_adjusting_asset_id
      t.integer :accessory_id
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end
