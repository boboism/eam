class AccessoryAdjustmentItemFrom < AccessoryAdjustmentItem
  attr_accessible :amount, :brand, :model, :name, :serial_no, :specification, :store_location, :accessory_adjusting_asset_id, :accessory_id, :updated_by_id, :created_by_id, :accessory_id

  belongs_to :accessory_adjustment, :class_name => "AccessoryAdjustment", :foreign_key => "accessory_adjustment_id"
  belongs_to :accessory, :class_name => "Accessory", :foreign_key => "accessory_id"

  class << self
    def new_by_asset_accessory(acc = nil, default_attrs = {})
      return new(default_attrs.merge(:accessory_id => acc.id)) do |instance|
        AccessoryAdjustmentItem::AccessoryAttributes.each{|attr| instance.__send__("#{attr}=", acc.__send__(attr)) }
      end
    end
  end
end
