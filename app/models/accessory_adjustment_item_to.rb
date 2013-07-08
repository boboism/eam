class AccessoryAdjustmentItemTo < AccessoryAdjustmentItem
  attr_accessible :amount, :brand, :model, :name, :serial_no, :specification, :store_location, :accessory_adjusting_asset_id, :updated_by_id, :created_by_id, :accessory_id

  belongs_to :accessory_adjusting_asset, :class_name => "AccessoryAdjustingAsset", :foreign_key => "accessory_adjusting_asset_id"
  belongs_to :accessory, :class_name => "Accessory", :foreign_key => "accessory_id"

  Accessory.validators.each do |validator|
    validator.attributes.each do |attr|
      if AccessoryAdjustmentItem::AccessoryAttributes.include?(attr)
        options = {:attributes => [attr.to_sym]}.merge(validator.options).delete_if{|key,value| [:if, :unless].include?(key)}
        validates_with(validator.class, options)
      end 
    end 
  end

  class << self
    def new_by_accessory_adjustment_item_from(fm = nil, default_attrs = {})
      return new(default_attrs) do |instance|
        AccessoryAdjustmentItem::AccessoryAttributes.each{|attr| instance.__send__("#{attr}=", fm.__send__(attr)) }
      end
    end
  end
end
