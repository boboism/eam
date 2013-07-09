class CreateAssetInfoAdjustments < ActiveRecord::Migration
  def change
    create_table :asset_info_adjustments do |t|
      t.integer :asset_id
      t.date :effective_date
      t.string :asset_name_from
      t.string :asset_name_to
      t.string :brand_from
      t.string :brand_to
      t.string :model_from
      t.string :model_to
      t.string :serial_no_from
      t.string :serial_no_to
      t.boolean :is_tariff_free_from
      t.boolean :is_tariff_free_to
      t.boolean :is_specific_fund_from
      t.boolean :is_specific_fund_to
      t.integer :tax_preference_id_from
      t.integer :tax_preference_id_to
      t.boolean :is_vat_free_from
      t.boolean :is_vat_free_to
      t.decimal :vat_from
      t.decimal :vat_to
      t.decimal :vat_rate_from
      t.decimal :vat_rate_to
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :confirmed_by_id
      t.datetime :confirmed_at
      t.boolean :confirmed
      t.datetime :approved_at
      t.integer :approved_by_id
      t.boolean :approved
      t.datetime :rejected_at
      t.integer :rejected_by_id
      t.boolean :rejected
      t.datetime :submitted_at
      t.integer :submitted_by_id
      t.boolean :submitted

      t.timestamps
    end

    add_index :asset_info_adjustments, [:asset_id], :name => "info_adj_asset"
    add_index :asset_info_adjustments, [:document_status], :name => "info_adj_stat"

  end
end
