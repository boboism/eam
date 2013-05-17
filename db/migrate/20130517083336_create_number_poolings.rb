class CreateNumberPoolings < ActiveRecord::Migration
  def change
    create_table :number_poolings do |t|
      t.string :type
      t.string :serial
      t.integer :status
      t.integer :owned_by_id

      t.timestamps
    end
  end
end
