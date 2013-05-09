class AssetInfoAdjustment < ActiveRecord::Base
  attr_accessible :approved_at, :approved_by_id, :asset_id, :asset_name_from, :asset_name_to, :brand_from, :brand_to, :confirmed_at, :confirmed_by_id, :created_by_id, :effective_date, :is_specific_fund_from, :is_specific_fund_to, :is_tariff_free_from, :is_tariff_free_to, :is_vat_free_from, :is_vat_free_to, :model_from, :model_to, :rejected_at, :rejected_by_id, :serial_no_from, :serial_no_to, :submitted_at, :submitted_by_id, :tax_preference_id_from, :tax_preference_id_to, :updated_by_id, :vat_from, :vat_rate_from, :vat_rate_to, :vat_to, :document_status

  belongs_to :asset, :class_name => "Asset", :foreign_key => "asset_id"
  belongs_to :tax_preference_from, :class_name => "TaxPreference", :foreign_key => "tax_preference_id_from"
  belongs_to :tax_preference_to, :class_name => "TaxPreference", :foreign_key => "tax_preference_id_to"

  scope :search, lambda{|search| }

  def self.asset_attributes
    [:asset_name, :brand, :model, :serial_no, :is_tariff_free, :is_specific_fund, :tax_preference_id, :is_vat_free, :vat, :vat_rate]
  end

  def self.new_with_asset(target=nil)
    instance = new
    if target && target.is_a?(Asset)
      instance.__send__("asset_id=", target.id)
      asset_attributes.each{|m|
        instance.__send__("#{m.to_s}_from=", target.__send__("#{m.to_s}"))
        instance.__send__("#{m.to_s}_to=", target.__send__("#{m.to_s}"))
      }
    end
    return instance
  end

  def changed_asset_attributes
    Array(self.class.asset_attributes.reject{ |attr| __send__("#{attr.to_s}_from") == __send__("#{attr.to_s}_to") }.collect{ |attr| attr.to_s =~ /_id$/ ? attr.to_s.gsub(/_id$/, "").to_sym : attr })
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
end
