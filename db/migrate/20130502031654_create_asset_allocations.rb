class CreateAssetAllocations < ActiveRecord::Migration
  def change
    create_table :asset_allocations do |t|
      t.integer :asset_id
      t.integer :management_department_id
      t.integer :cost_center_id
      t.integer :construction_period_id
      t.integer :specific_investment_id
      t.decimal :quantity
      t.boolean :enabled
      t.datetime :enabled_at
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :asset_allocations, [:asset_id], name: "asset_alloc_asset"
    add_index :asset_allocations, [:management_department_id], name: "asset_alloc_mgmt_dept"
    add_index :asset_allocations, [:cost_center_id], name: "asset_alloc_ccenter"
    add_index :asset_allocations, [:enabled], name: "asset_alloc_enabled"

  end
end
