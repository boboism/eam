class CreateAssetCategorizationItems < ActiveRecord::Migration
  def change
    create_table :asset_categorization_items do |t|
      t.integer :asset_id
      t.integer :category_id
      t.integer :sub_category_id
      t.string :asset_no
      t.string :asset_name
      t.string :brand
      t.string :model
      t.string :specification
      t.string :serial_no
      t.string :purchase_no
      t.date :arrival_date
      t.string :design_company
      t.string :construction_company
      t.date :construction_date_from
      t.date :construction_date_to
      t.decimal :quantity
      t.decimal :amount
      t.decimal :conversion_rate
      t.string :supplier
      t.string :contract_no
      t.string :usage
      t.string :remark
      t.integer :asset_categorization_id

      t.timestamps
    end
  end
end
