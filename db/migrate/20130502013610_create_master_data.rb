class CreateMasterData < ActiveRecord::Migration
  def change
    create_table :master_data do |t|
      t.string :code
      t.string :name
      t.string :description
      t.integer :parent_id
      t.text :profiles
      t.string :type
      t.boolean :enabled, default: true
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :master_data, [:type, :code], :name => "master_data_type_code", :unique => true
    add_index :master_data, [:enabled], :name => "master_data_enabled"
    add_index :master_data, [:type, :name], :name => "master_data_type_name"
  end
end
