class AssetTransferItemFrom < AssetTransferItem
  attr_accessible :asset_allocation_id, :asset_transfer_id, :construction_period_id, :cost_center_id, :created_by_id, :management_department_id, :quantity, :specific_investment_id, :type, :updated_by_id

  class << self
    def new_by_asset_allocation(alloc=nil, default_attrs={})
      AssetTransferItemFrom.new(default_attrs.merge(:asset_allocation_id => alloc.id)) do |trans_fm|
        AssetTransferItem::AllocationAttributes.each{|attr| trans_fm.__send__("#{attr.to_s}=", alloc.__send__("#{attr.to_s}"))}
      end
    end
  end
end
