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
      t.string :supplier
      t.string :contract_no
      t.string :usage
      t.string :remark
      t.integer :asset_categorization_id
      t.decimal :allocation_propotion, default: 100, precision: 18, scale: 2
      t.integer :cost_center_id
      t.integer :management_department_id
      t.date :warranty_date_from, default: Date.current
      t.date :warranty_date_to, default: Date.current
      t.integer :warranty_period, default: 0
      t.integer :store_location_id
      t.string :responsible_by
      t.decimal :original_cost, default: 0, precision: 18, scale: 2
      t.decimal :vat, default: 0, precision: 18, scale: 2
      t.decimal :vat_rate, default: 0, precision: 18, scale: 2
      t.boolean :is_energy_saving, default: false
      t.boolean :is_env_protection, default: false
      t.boolean :is_research_use, default: false
      t.boolean :is_safety_production, default: false
      t.integer :construction_period_id
      t.integer :specific_investment_id
      t.integer :accessory_status

      t.timestamps
    end
  end
end
