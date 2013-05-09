class AssetAllocation < ActiveRecord::Base
  attr_accessible :asset_id, :construction_period_id, :cost_center_id, :created_by_id, :enabled, :enabled_at, :management_department_id, :quantity, :specific_investment_id, :updated_by_id

  belongs_to :asset, :class_name => "Asset", :foreign_key => "asset_id"
end
