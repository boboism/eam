class AssetTransferItemTo < AssetTransferItem
  attr_accessible :asset_allocation_id, :asset_transfer_id, :construction_period_id, :cost_center_id, :created_by_id, :management_department_id, :quantity, :specific_investment_id, :updated_by_id, :responsible_by, :updated_at, :created_at

  validates :construction_period, presence: true
  validates :cost_center, presence: true
  #validates :created_by, presence: true
  validates :management_department, presence: true
  validates :quantity, presence: true, numericality: {less_than_or_equal_to: 1, greater_than: 0}
  validates :specific_investment, presence: true
  #validates :updated_by, presence: true
  validates :responsible_by, presence: true


  belongs_to :asset_allocation, :class_name => "AssetAllocation", :foreign_key => "asset_allocation_id"
  belongs_to :transfering_asset, :class_name => "TransferingAsset", :foreign_key => "transfering_asset_id"
  belongs_to :construction_period, :class_name => "ConstructionPeriod", :foreign_key => "construction_period_id"
  belongs_to :cost_center, :class_name => "CostCenter", :foreign_key => "cost_center_id"
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
  belongs_to :management_department, :class_name => "Department", :foreign_key => "management_department_id"
  belongs_to :specific_investment, :class_name => "SpecificInvestment", :foreign_key => "specific_investment_id"

  class << self
    def new_by_asset_transfer_item_from(trans_fm=nil, default_attrs={})
      AssetTransferItemTo.new(default_attrs) do |trans_to|
        AssetTransferItem::AllocationAttributes.each{|attr| trans_to.__send__("#{attr.to_s}=", trans_fm.__send__("#{attr.to_s}"))}
      end
    end
  end
end
