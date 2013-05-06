class TransferingAsset < ModelRelationship
  attr_accessible :refer_id_from, :refer_id_to, :created_by_id, :updated_by_id

  belongs_to :asset_transfer, :class_name => "AssetTransfer", :foreign_key => "refer_id_from"
  belongs_to :asset, :class_name => "Asset", :foreign_key => "refer_id_to"

  has_many :asset_transfer_item_froms, :class_name => "AssetTransferItemFrom", :foreign_key => "transfering_asset_id"
  accepts_nested_attributes_for :asset_transfer_item_froms
  has_many :asset_transfer_item_tos, :class_name => "AssetTransferItemTo", :foreign_key => "transfering_asset_id"
  accepts_nested_attributes_for :asset_transfer_item_tos

  def transfer_item_tos_total_quantity
    asset_transfer_item_tos.map(&:quantity).delete_if(&:nil?).inject(0, &:+)
  end

end
