class CreateAccessories < ActiveRecord::Migration
  def change
    create_table :accessories do |t|
      t.string :name
      t.string :brand
      t.string :model
      t.string :specification
      t.string :serial_no
      t.string :store_location
      t.decimal :amount
      t.boolean :enabled
      t.integer :asset_id
      t.integer :created_by_id
      t.integer :updated_by_id
      t.boolean :enabled

      t.timestamps
    end
  end
end
