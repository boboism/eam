class AssetAllocation < ActiveRecord::Base
  attr_accessible :asset_id, :construction_period_id, :cost_center_id, :created_by_id, :enabled, :enabled_at, :management_department_id, :allocation_propotion, :specific_investment_id, :updated_by_id, :asset_transfer_item_from_attributes, :responsible_by

  #validates :allocation_propotion, :presence => true, :numbericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}

  belongs_to :asset, :class_name => "Asset", :foreign_key => "asset_id"

  has_one :asset_transfer_item_to, :class_name => "AssetTransferItemTo", :foreign_key => "asset_allocation_id"
  has_one :asset_transfer_item_from, :class_name => "AssetTransferItemFrom", :foreign_key => "asset_allocation_id"

  def asset_allocation_id;id;end

  class << self
    # initializer for asset transfering
    def new_by_asset_transfer_item_to(trans_to=nil, default_attrs={})
      new(default_attrs.merge(:asset_id => trans_to.transfering_asset.asset.id, :enabled => true, :enabled_at => DateTime.now)) do |alloc|
        AssetTransferItem::AllocationAttributes.each do |attr| 
          alloc.__send__("#{attr.to_s}=", trans_to.__send__("#{attr.to_s}"))
        end
      end
    end

    def new_by_asset_categorization_item(asset_categorization_item, user)
      new(:enabled => true, :enabled_at => DateTime.now, :created_by_id => user.id, :updated_by_id => user.id) do |alloc|
        AssetCategorizationItem::AssetAllocationAttributes.each do |attr|
          alloc.__send__("#{attr.to_s}=", asset_categorization_item.__send__("#{attr.to_s}"))
        end
      end
    end
  end

  def disabled_by(user=nil)
    update_attributes(:enabled => false, :updated_by_id => user.id)
  end

end
