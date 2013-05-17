class CreateAssetCategorizations < ActiveRecord::Migration
  def change
    create_table :asset_categorizations do |t|
      t.integer :categorize_type
      t.integer :created_by_id
      t.integer :updated_by_id
      t.boolean :submitted, :default => false
      t.integer :submitted_by_id
      t.datetime :submitted_at
      t.boolean :confirmed, :default => false
      t.integer :confirmed_by_id
      t.datetime :confirmed_at
      t.boolean :approved, :default => false
      t.integer :approved_by_id
      t.datetime :approved_at
      t.string :doc_status
      t.integer :items_count, :default => 0

      t.timestamps
    end
  end
end
