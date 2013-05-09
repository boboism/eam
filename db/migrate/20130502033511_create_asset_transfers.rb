class CreateAssetTransfers < ActiveRecord::Migration
  def change
    create_table :asset_transfers do |t|
      t.date :effective_date
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :confirmed_by_id
      t.datetime :confirmed_at
      t.datetime :approved_at
      t.integer :approved_by_id
      t.datetime :rejected_at
      t.integer :rejected_by_id
      t.integer :submitted_by_id
      t.integer :submitted_at
      t.boolean :published
      t.datetime :published_at
      t.string :document_status
      t.integer :transfer_type

      t.timestamps
    end

    add_index :asset_transfers, [:document_status], :name => "asset_transfers_stat"

  end
end
