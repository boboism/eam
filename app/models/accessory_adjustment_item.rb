class AccessoryAdjustmentItem < ActiveRecord::Base
  attr_accessible :amount, :brand, :model, :name, :serial_no, :specification, :store_location, :type, :accessory_adjusting_asset_id, :accessory_id

  AccessoryAttributes = [:amount, :brand, :model, :name, :serial_no, :specification, :store_location]
end
