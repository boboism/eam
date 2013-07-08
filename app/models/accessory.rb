class Accessory < ActiveRecord::Base
  attr_accessible :amount, :brand, :model, :name, :serial_no, :specification, :store_location, :asset_id, :created_by_id, :updated_by_id, :enabled

  validates :name,   :presence => true

  class << self
    def new_by_accessory_adjustment_item_to(item, user)
      default_attrs = {:created_by_id => user.id, 
                       :updated_by_id => user.id, 
                       :enabled       => true, 
                       :asset_id      => item.accessory_adjusting_asset.asset.id
      }
      new(default_attrs) do |instance|
        AccessoryAdjustmentItem::AccessoryAttributes.each do |attr|
          instance.__send__("#{attr}=", item.__send__(attr)) 
        end
      end
    end
  end

  def disable_by(user)
    update_attributes(:enabled => false, :updated_by_id => user.id)
  end

end
