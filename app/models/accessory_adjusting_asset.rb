class AccessoryAdjustingAsset < ModelRelationship
  attr_accessible :refer_id_from, :refer_id_to, :created_by_id, :updated_by_id, :asset_id, :accessory_adjustment_item_froms_attributes, :accessory_adjustment_item_tos_attributes

  belongs_to :accessory_adjustment, :class_name => "AccessoryAdjustment", :foreign_key => "refer_id_from"
  belongs_to :asset, :class_name => "Asset", :foreign_key => "refer_id_to"
  has_many :accessory_adjustment_item_froms, :class_name => "AccessoryAdjustmentItemFrom", :foreign_key => "accessory_adjusting_asset_id", :dependent => :destroy
  has_many :accessory_adjustment_item_tos, :class_name => "AccessoryAdjustmentItemTo", :foreign_key => "accessory_adjusting_asset_id", :dependent => :destroy
  accepts_nested_attributes_for :accessory_adjustment_item_froms, :allow_destroy => true
  accepts_nested_attributes_for :accessory_adjustment_item_tos, :reject_if => lambda{|attrs| attrs[:name].blank? }, :allow_destroy => true

  #validates :refer_id_from, :presence => true
  #validates :refer_id_to, :presence => true

  def asset_id; refer_id_to; end
  def asset_id=(value); self.refer_id_to = value; end
end
