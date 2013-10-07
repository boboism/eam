class CreateAssetTransfers < ActiveRecord::Migration
  def change
    create_table :asset_transfers do |t|
      t.date :effective_date, default: DateTime.now
      t.integer :created_by_id
      t.integer :updated_by_id
      t.boolean :confirmed, default: false
      t.integer :confirmed_by_id
      t.datetime :confirmed_at
      t.datetime :approved_at
      t.boolean :approved, default: false
      t.integer :approved_by_id
      t.datetime :rejected_at
      t.integer :rejected_by_id
      t.boolean :submitted, default: false
      t.integer :submitted_by_id
      t.datetime :submitted_at
      t.boolean :published, default: false
      t.datetime :published_at
      t.integer :transfer_type

      t.timestamps
    end

  end
end
