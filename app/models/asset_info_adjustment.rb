class AssetInfoAdjustment < ActiveRecord::Base
  attr_accessible :approved_at, :approved_by_id, :asset_id, :asset_name_from, :asset_name_to, :brand_from, :brand_to, :confirmed_at, :confirmed_by_id, :created_by_id, :effective_date, :is_specific_fund_from, :is_specific_fund_to, :is_tariff_free_from, :is_tariff_free_to, :is_vat_free_from, :is_vat_free_to, :model_from, :model_to, :rejected_at, :rejected_by_id, :serial_no_from, :serial_no_to, :submitted_at, :submitted_by_id, :updated_by_id, :vat_from, :vat_rate_from, :vat_rate_to, :vat_to, :submitted, :approved, :confirmed

  AssetAttributes = [:asset_name, :brand, :model, :serial_no, :is_tariff_free, :is_specific_fund, :is_vat_free, :vat, :vat_rate]

  # use asset validators for the attributes in asset
  Asset.validators.each do |validator|
    validator.attributes.each do |attr|
      if AssetAttributes.include?(attr)
        options = {:attributes => ["#{attr}_to".to_sym]}.merge(validator.options).delete_if{|key,value| [:if, :unless].include?(key)}
        validates_with(validator.class, options)
      end
    end
  end
  
  belongs_to :asset, :class_name => "Asset", :foreign_key => "asset_id"
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
  belongs_to :submitted_by, class_name: "User", foreign_key: "submitted_by_id"
  belongs_to :confirmed_by, class_name: "User", foreign_key: "confirmed_by_id"
  belongs_to :approved_by, class_name: "User", foreign_key: "approved_by_id"
  belongs_to :rejected_by, class_name: "User", foreign_key: "rejected_by_id"

  scope :search, lambda{|search| }

  def self.new_with_asset(target=nil, defaults={})
    instance = new
    instance.attributes = defaults
    if target && target.is_a?(Asset)
      instance.__send__("asset_id=", target.id)
      AssetAttributes.each{|m|
        instance.__send__("#{m}_from=", target.__send__("#{m}"))
        instance.__send__("#{m}_to=", target.__send__("#{m}")) unless target.__send__(m).nil?
      }
    end
    return instance
  end

  def changed_asset_attributes
    Array(AssetAttributes.reject{ |attr| __send__("#{attr.to_s}_from") == __send__("#{attr.to_s}_to") }.collect{ |attr| attr.to_s =~ /_id$/ ? attr.to_s.gsub(/_id$/, "").to_sym : attr })
  end

  def changed_asset_contents(use_locale = false)
    changed_asset_attributes.inject({}){ |acc, attr| 
      attr_fm = __send__("#{attr.to_s}_from")
      attr_to = __send__("#{attr.to_s}_to")
      if use_locale
        attr_fm = attr_fm == !!attr_fm ? I18n.t(attr_fm.__send__("to_s")) : attr_fm.__send__("to_s")
        attr_to = attr_to == !!attr_to ? I18n.t(attr_to.__send__("to_s")) : attr_to.__send__("to_s")
        attr = Asset.human_attribute_name(attr) 
      else
        attr_fm = attr_fm.__send__("to_s")
        attr_to = attr_to.__send__("to_s")
      end
      acc.merge(attr => [attr_fm, attr_to]) 
    }
  end

  def changed_asset_html(use_locale = false, spliter = "")
    changed_asset_contents(use_locale).inject([]){|acc, content| acc << "#{content.first}: \"#{content.last.first}\" => \"#{content.last.last}\""}.join(spliter) 
  end

  def submit!(user=nil)
    errors.add(:submitted, I18n.t("activerecord.attributes.asset_info_adjustment.transactions.already_submitted", :at => submitted_at, :by => submitted_by)) && return if submitted?
    self.transaction do
      update_attributes(:submitted => true, :submitted_by_id => user.id, :submitted_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def confirm!(user=nil)
    errors.add(:confirmed, I18n.t("activerecord.attributes.asset_info_adjustment.transactions.already_confirmed", :at => confirmed_at, :by => confirmed_by)) && return if confirmed?
    self.transaction do
      update_attributes(:confirmed => true, :confirmed_by_id => user.id, :confirmed_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def approve!(user=nil)
    errors.add(:approved, I18n.t("activerecord.attributes.asset_transfer.transactions.already_approved", :at => approved_at, :by => approved_by)) && return if approved?
    self.transaction do
      AssetAttributes.each{|m| asset.__send__("#{m}=", __send__("#{m}_to")); }
      asset.save
      update_attributes(:approved => true, :approved_by_id => user.id, :approved_at => DateTime.now, :updated_by_id => user.id)
    end
  end

#  STATUS_TYPE = {
#    editable:  {weight: 1 << 0},
#    submitted: {weight: 1 << 1},
#    confirmed: {weight: 1 << 2},
#    approved:  {weight: 1 << 3}
#  }
#  STATUS_TYPE.each do |key, value|
#    send(:define_method, "#{key}?") do
#      self.status == value[:weight]
#    end
#  end

end
