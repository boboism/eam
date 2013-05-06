class CreateAssetCostAdjustments < ActiveRecord::Migration
  def change
    create_table :asset_cost_adjustments do |t|
      t.integer :asset_id
      t.date :effective_date
      t.decimal :original_cost_from
      t.decimal :original_cost_to
      t.decimal :salvage_from
      t.decimal :salvage_to
      t.decimal :salvage_rate_from
      t.decimal :salvage_rate_to
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :confirmed_by_id
      t.datetime :confirmed_at
      t.integer :approved_by_id
      t.datetime :approved_at
      t.integer :rejected_by_id
      t.datetime :rejected_at
      t.boolean :published
      t.datetime :published_at
      t.integer :submitted_by_id
      t.datetime :submitted_at
      t.string :document_status

      t.timestamps
    end

    add_index :asset_cost_adjustments, [:asset_id], :name => "cost_adj_asset"
    add_index :asset_cost_adjustments, [:document_status], :name => "cost_adj_stat"

  end
end
