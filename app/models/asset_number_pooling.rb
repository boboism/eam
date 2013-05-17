class AssetNumberPooling < NumberPooling
  attr_accessible :serial, :status, :owned_by_id

  belongs_to :asset, :class_name => "Asset", :foreign_key => "owned_by_id"

  StatusType = {
    :available => {:weight => (1 << 0)},
    :reserved  => {:weight => (1 << 1)},
    :taken     => {:weight => (1 << 2)}
  }

  StatusType.each_pair{|key, value| scope(key, lambda{where(:status => value[:weight])}) }
  scope :in_category, lambda{|category| where{(serial =~ "#{category.number_pooling_prefix}%")}}

  class << self
    def arrange_sub_category_number_pooling(sub_category)
      return false unless sub_category.is_a? SubCategory
      self.transaction do 
        (1..999).all? do |serial|
          create(:serial => "#{sub_category.number_pooling_prefix}#{'%03d' % serial}",:status => StatusType[:available][:weight])
        end
      end
    end

    def next(sub_category)
     raise I18n.t("activerecord.attributes.asset_number_pooling.no_available_number", :cat => "#{sub_category.number_pooling_prefix}#{sub_category.name}") unless num = in_category(sub_category).available.first
     num
    end
  end

  def owned_by!(asset)
    self.transaction do
      update_attributes(:owned_by_id => asset.id)
    end
  end

end