class CreateAccessoryAdjustments < ActiveRecord::Migration
  def change
    create_table :accessory_adjustments do |t|
      t.date :effective_date, default: Time.now
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :submitted_by_id
      t.datetime :submitted_at
      t.boolean :submitted, default: false
      t.boolean :confirmed, default: false
      t.integer :confirmed_by_id
      t.datetime :confirmed_at
      t.boolean :approved, default: false
      t.datetime :approved_at
      t.integer :approved_by_id

      t.timestamps
    end
  end
end
