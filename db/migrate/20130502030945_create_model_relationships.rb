class CreateModelRelationships < ActiveRecord::Migration
  def change
    create_table :model_relationships do |t|
      t.string :type
      t.integer :refer_id_from
      t.integer :refer_id_to
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :model_relationships, [:type, :refer_id_from, :refer_id_to], :name => "model_rel_fm_to", :unique => true
    add_index :model_relationships, [:type, :refer_id_from], :name => "model_rel_fm", :unique => true
    add_index :model_relationships, [:type, :refer_id_to], :name => "model_rel_to", :unique => true

  end
end
