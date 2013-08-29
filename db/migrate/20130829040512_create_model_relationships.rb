class CreateModelRelationships < ActiveRecord::Migration
  def change
    create_table :model_relationships do |t|
      t.integer :refer_from_id
      t.string :refer_from_type
      t.integer :refer_from_status
      t.integer :refer_to_id
      t.string :refer_to_type
      t.integer :refer_to_status
      t.string :type
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end
