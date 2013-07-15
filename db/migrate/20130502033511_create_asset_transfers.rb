class CreateAssetTransfers < ActiveRecord::Migration
  def change
    create_table :asset_transfers do |t|
      t.date :effective_date
      t.integer :created_by_id
      t.integer :updated_by_id
      t.boolean :confirmed
      t.integer :confirmed_by_id
      t.datetime :confirmed_at
      t.datetime :approved_at
      t.boolean :approved
      t.integer :approved_by_id
      t.datetime :rejected_at
      t.integer :rejected_by_id
      t.boolean :submitted
      t.integer :submitted_by_id
      t.datetime :submitted_at
      t.boolean :published
      t.datetime :published_at
      t.integer :transfer_type

      t.timestamps
    end

  end
end
