class AssetTransferItem < ActiveRecord::Base
  attr_accessible :asset_allocation_id, :transfering_asset_id, :construction_period_id, :cost_center_id, :created_by_id, :management_department_id, :quantity, :specific_investment_id, :type, :updated_by_id, :responsible_by

  belongs_to :asset_allocation, :class_name => "AssetAllocation", :foreign_key => "asset_allocation_id"
  belongs_to :transfering_asset, :class_name => "TransferingAsset", :foreign_key => "transfering_asset_id"
  belongs_to :construction_period, :class_name => "ConstructionPeriod", :foreign_key => "construction_period_id"
  belongs_to :cost_center, :class_name => "CostCenter", :foreign_key => "cost_center_id"
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :management_department, :class_name => "Department", :foreign_key => "management_department_id"
  belongs_to :specific_investment, :class_name => "SpecificInvestment", :foreign_key => "specific_investment_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"

  AllocationAttributes = [:construction_period_id, :cost_center_id, :management_department_id, :quantity, :specific_investment_id, :responsible_by]

end
