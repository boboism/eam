class AccessoryAdjustment < ActiveRecord::Base
  attr_accessible :approved, :approved_at, :approved_by_id, :confirmed, :confirmed_at, :confirmed_by_id, :created_by_id, :effective_date, :submitted, :submitted_at, :submitted_by_id, :updated_by_id, :rejected_by_id, :rejected_at, :rejected, :accessory_adjusting_assets_attributes

  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
  belongs_to :submitted_by, :class_name => "User", :foreign_key => "submitted_by_id"
  belongs_to :confirmed_by, :class_name => "User", :foreign_key => "confirmed_by_id"
  belongs_to :approved_by, :class_name => "User", :foreign_key => "approved_by_id"

  has_many :accessory_adjusting_assets, :class_name => "AccessoryAdjustingAsset", :foreign_key => "refer_from_id", :dependent => :destroy
  has_many :assets, :class_name => "Asset", :through => :accessory_adjusting_assets
  has_many :accessory_adjustment_item_tos, :class_name => "AccessoryAdjustmentItemTo", :through => :accessory_adjusting_assets
  has_many :accessory_adjustment_item_froms, :class_name => "AccessoryAdjustmentItemFrom", :through => :accessory_adjusting_assets
  accepts_nested_attributes_for :accessory_adjusting_assets, :reject_if => lambda{|attrs| attrs[:refer_to_id].nil? }

  validates :created_by_id, :updated_by_id, :presence => true
  validates :effective_date, :presence => true, :date => {:on_or_after => Date.current}

  default_scope { order{id.desc} }

  scope :search, lambda{|search|}
  scope :not_approved, lambda { where{-(approved == true)} }

  class << self
    def new_by_asset_and_user(targets = [], user = nil)
      targets, default_attrs = Array(targets), {:created_by_id => user.id, :updated_by_id => user.id}
      new(default_attrs.merge(:submitted => false, :confirmed => false, :approved => false)) do |instance|
        instance.accessory_adjusting_assets << targets.collect do |asset|
          AccessoryAdjustingAsset.new(default_attrs.merge(:asset_id => asset.id)) do |adj_rec|
            adj_rec.accessory_adjustment_item_froms << adj_rec.asset.accessories.collect do |acc|
              AccessoryAdjustmentItemFrom.new_by_asset_accessory(acc, default_attrs)
            end
            if adj_rec.accessory_adjustment_item_froms.empty? 
              adj_rec.accessory_adjustment_item_tos << AccessoryAdjustmentItemTo.new(default_attrs) 
            else
              adj_rec.accessory_adjustment_item_tos << adj_rec.accessory_adjustment_item_froms.collect do |fm|
                AccessoryAdjustmentItemTo.new_by_accessory_adjustment_item_from(fm, default_attrs)
              end
            end
          end
        end
      end
    end
  end

  def submit!(user)
    errors.add(:submitted, I18n.t("activerecord.attributes.asset_categorization.transactions.already_submitted", :at => submitted_at, :by => submitted_by)) && return if submitted?
    self.transaction do
      update_attributes(:submitted => true, :submitted_by_id => user.id, :submitted_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def confirm!(user)
    errors.add(:confirmed, I18n.t("activerecord.attributes.asset_categorization.transactions.already_confirmed", :at => confirmed_at, :by => confirmed_by)) && return if confirmed?
    self.transaction do
      update_attributes(:confirmed => true, :confirmed_by_id => user.id, :confirmed_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def approve!(user)
    errors.add(:approved, I18n.t("activerecord.attributes.asset_categorization.transactions.already_approved", :at => approved_at, :by => approved_by)) && return if approved?
    self.transaction do
      accessory_adjustment_item_tos.each do |item|
        Accessory.new_by_accessory_adjustment_item_to(item, user).save
      end
      accessory_adjustment_item_froms.collect(&:accessory).each{|acc| acc.disable_by(user); }
      update_attributes(:approved => true, :approved_by_id => user.id, :approved_at => DateTime.now, :updated_by_id => user.id)
      asset.update_attributes(accessory_status: AccessoryStatusType[:exists][:weight],
                              updated_by_id: user.id)
    end
  end


end
