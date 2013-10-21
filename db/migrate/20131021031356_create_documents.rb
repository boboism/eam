class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :description
      t.integer :documentable_id
      t.string :documentable_type
      t.string :type
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
