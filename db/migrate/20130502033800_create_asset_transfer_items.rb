class CreateAssetTransferItems < ActiveRecord::Migration
  def change
    create_table :asset_transfer_items do |t|
      t.string :type
      t.integer :transfering_asset_id
      t.integer :asset_allocation_id
      t.integer :management_department_id
      t.integer :cost_center_id
      t.integer :construction_period_id
      t.integer :specific_investment_id
      t.decimal :quantity
      t.integer :created_by_id
      t.integer :updated_by_id
      t.string :responsible_by

      t.timestamps
    end

    add_index :asset_transfer_items, [:type], :name => "trans_items_type"

  end
end
