class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :asset_no
      t.string :device_no
      t.string :asset_name
      t.string :brand
      t.string :model
      t.string :specification
      t.string :serial_no
      t.integer :category_id
      t.integer :sub_category_id
      t.decimal :original_cost
      t.decimal :salvage
      t.decimal :salvage_rate
      t.integer :activated_by_id
      t.datetime :activated_at
      t.boolean :activated
      t.integer :accepted_by_id
      t.boolean :accepted
      t.datetime :accepted_at
      t.boolean :is_tariff_free
      t.boolean :is_specific_fund
      t.boolean :is_vat_free
      t.decimal :vat
      t.decimal :vat_rate
      t.integer :created_by_id
      t.integer :updated_by_id
      t.boolean :published
      t.datetime :published_at
      t.string :approval_no
      t.string :purchase_no
      t.date :arrival_date
      t.string :design_company
      t.string :construction_company
      t.string :contract_no
      t.string :supplier
      t.date :construction_date_from
      t.date :construction_date_to
      t.text :remark
      t.integer :accessory_status 

      t.timestamps
    end

    add_index :assets, [:asset_no], :name => "assets_asset_no"
    add_index :assets, [:category_id], :name => "assets_cat"
    add_index :assets, [:sub_category_id], :name => "assets_sub_cat"
    add_index :assets, [:accepted], :name => "assets_accepted"
    add_index :assets, [:activated], :name => "assets_activated"
    add_index :assets, [:published], :name => "assets_published"
    add_index :assets, [:accessory_status], :name => "assets_acc_stat"

  end
end
