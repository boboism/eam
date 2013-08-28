class CreateNumberPoolings < ActiveRecord::Migration
  def change
    create_table :number_poolings do |t|
      t.string :type
      t.string :serial
      t.integer :status
      t.integer :owned_by_id

      t.timestamps
    end
    
    add_index :number_poolings, [:type], :name => "number_poolings_type"
    add_index :number_poolings, [:status], :name => "number_poolings_status"
    add_index :number_poolings, [:owned_by_id], :name => "number_poolings_owned"
    add_index :number_poolings, [:serial], :name => "number_poolings_serial"
  end
end
