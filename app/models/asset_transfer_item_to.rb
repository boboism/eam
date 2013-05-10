class AssetTransferItemTo < AssetTransferItem
  # attr_accessible :title, :body
  #

  class << self
    def new_with_asset_transfer_item_from(trans_fm=nil, default_attrs={})
      AssetTransferItemTo.new(default_attrs) do |trans_to|
        AssetTransferItem::AllocationAttributes.each{|attr| trans_to.__send__("#{attr.to_s}=", trans_fm.__send__("#{attr.to_s}"))}
      end
    end
  end
end
