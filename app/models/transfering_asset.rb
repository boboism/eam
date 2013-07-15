class TransferingAsset < ModelRelationship
  attr_accessible :refer_id_from, :refer_id_to, :created_by_id, :updated_by_id, :asset_id, :asset_transfer_item_tos_attributes, :asset_transfer_item_froms_attributes

  belongs_to :asset_transfer, :class_name => "AssetTransfer", :foreign_key => "refer_id_from"
  belongs_to :asset, :class_name => "Asset", :foreign_key => "refer_id_to"

  validate :validate_item_tos_total_quantity_euqals_to_one

  with_options :dependent => :destroy do |assoc|
    assoc.has_many :asset_transfer_item_froms, :class_name => "AssetTransferItemFrom", :foreign_key => "transfering_asset_id"
    assoc.has_many :asset_transfer_item_tos, :class_name => "AssetTransferItemTo", :foreign_key => "transfering_asset_id"
  end
  accepts_nested_attributes_for :asset_transfer_item_froms, :allow_destroy => true
  accepts_nested_attributes_for :asset_transfer_item_tos, :allow_destroy => true

  def asset_id=(value); self.refer_id_to=value;end
  def asset_id;self.refer_id_to;end

  def transfer_item_tos_total_quantity
    asset_transfer_item_tos.map(&:quantity).delete_if(&:nil?).inject(0, &:+)
  end

  private
  def validate_item_tos_total_quantity_euqals_to_one
    current_quantity = asset_transfer_item_tos.map(&:quantity).inject(0,&:+)
    errors.add(:asset_transfer_item_tos, I18n.t('activerecord.errors.models.asset_transfer.item_tos_total_quantity_euqals_to_one', current_quantity: current_quantity)) unless current_quantity == 1
  end

end
