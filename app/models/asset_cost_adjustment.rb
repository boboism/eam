class AssetCostAdjustment < ActiveRecord::Base
  attr_accessible :approved_at, :approved_by_id, :asset_id, :confirmed_at, :confirmed_by_id, :created_by_id, :effective_date, :original_cost_from, :original_cost_to, :published, :published_at, :rejected_at, :rejected_by_id, :salvage_from, :salvage_rate_from, :salvage_rate_to, :salvage_to, :updated_by_id, :submitted_by_id, :submitted_at, :submitted, :confirmed, :approved

  belongs_to :asset, :class_name => "Asset", :foreign_key => "asset_id"
  belongs_to :approved_by, :class_name => "User", :foreign_key => "approved_by_id"
  belongs_to :confirmed_by, :class_name => "User", :foreign_key => "confirmed_by_id"
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
  belongs_to :submitted_by, :class_name => "User", :foreign_key => "submitted_by_id"

  scope :search, lambda{|search|}

  AssetAttributes = [:original_cost, :salvage, :salvage_rate]
  def self.asset_attributes
    AssetAttributes
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

  def submit!(user=nil)
    errors.add(:submitted, I18n.t("activerecord.attributes.asset_cost_adjustment.transactions.already_submitted", :at => submitted_at, :by => submitted_by)) && return if submitted?
    self.transaction do
      update_attributes(:submitted => true, :submitted_by_id => user.id, :submitted_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def confirm!(user=nil)
    errors.add(:confirmed, I18n.t("activerecord.attributes.asset_cost_adjustment.transactions.already_confirmed", :at => confirmed_at, :by => confirmed_by)) && return if confirmed?
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

end
