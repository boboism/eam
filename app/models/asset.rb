class Asset < ActiveRecord::Base
  attr_accessible :accepted, :accepted_at, :accepted_by_id, :activated, :activated_at, :activated_by_id, :asset_name, :asset_no, :brand, :category_id, :created_by_id, :is_specific_fund, :is_tariff_free, :is_vat_free, :model, :original_cost, :published, :published_at, :salvage, :salvage_rate, :serial_no, :sub_category_id, :updated_by_id, :vat, :vat_rate, :supplier, :specification, :accessory_status

  AccessoryStatusType = {
    :to_be_defined => {
      :weight => (1 << 0), 
      :description => I18n.t("activerecord.attributes.asset.accessory_status_types.to_be_defined")},
    :none => {
      :weight => (1 << 1),
      :description => I18n.t("activerecord.attributes.asset.accessory_status_types.none")},
    :exists => {
      :weight => (1 << 2),
      :description => I18n.t("activerecord.attributes.asset.accessory_status_types.exists")}
  }

  #validates :accepted, :presence => true
  with_options :if => :accepted? do |a|
    a.validates :accepted_by_id, :presence => true
    a.validates :accepted_at, :presence => true
    a.validates :asset_name, :presence => true, :if => :activated
    a.validates :category_id, :presence => true, :if => :activated
    #a.validates :is_specific_fund, :presence => true
    #a.validates :is_tariff_free, :presence => true
    #a.validates :is_vat_free, :presence => true
    a.validates :sub_category_id, :presence => true
    a.validates :salvage, :presence => true, :numericality => {:greater_than => 0}
    a.validates :salvage_rate, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
    a.validates :vat_rate, :presence => true, :numericality => {:greater_than_or_equal_to => 0}, unless: :is_vat_free
    a.validates :vat, presence: true, numericality: {greater_than_or_euqal_to: 0}, unless: :is_vat_free
  end

  #validates :activated, :presence => true
  with_options :if => :activated? do |a|
    a.validates :activated_by_id, :presence => true
    a.validates :activated_at, :presence => true
  end

  validates :created_by_id, :presence => true
  validates :original_cost, :presence => true, :numericality => {:greater_than => 0}
  validates :serial_no, :presence => true
  validates :updated_by_id, :presence => true

  #validates :published, :presence => true
  with_options :if => :published? do |a|
    a.validates :published_at, :presence => true
  end

  belongs_to :accepted_by, :class_name => "User"
  belongs_to :activated_by, :class_name => "User"
  belongs_to :category, :class_name => "Category"
  belongs_to :sub_category, :class_name => "SubCategory"
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"

  has_one :asset_categorization_item, :class_name => "AssetCategorizationItem", :foreign_key => "asset_id"
  has_one :asset_categorization, :class_name => "AssetCategorization", :through => :asset_categorization_item
  has_many :transfering_assets, :class_name => "TransferingAsset", :foreign_key => "refer_to_id" 
  has_many :asset_transfers, :class_name => "AssetTransfer", :through => :transfering_assets
  has_many :allocations, :class_name => "AssetAllocation", :foreign_key => "asset_id", :conditions => {:enabled => true}
  has_many :accessories, :class_name => "Accessory", :foreign_key => "asset_id", :conditions => {:enabled => true}
  has_many :accessory_adjusting_assets, :class_name => "AccessoryAdjustingAsset", :foreign_key => "refer_to_id"

  scope :search, lambda { |search|
  }

  scope :accessories_defined, lambda {
    where{accessory_status.in(AccessoryStatusType.delete_if{|key,value| key == :to_be_defined}.collect{|key,value| value[:weight]})}
  }
  scope :accessories_to_be_defined, lambda{where(:accessory_status => AccessoryStatusType[:to_be_defined][:weight])}

  class << self
    def new_by_asset_categorization_item(asset_categorization_item, user)
      new(:created_by_id => user.id, :updated_by_id => user.id) do |a|
        AssetCategorizationItem::AssetAttributes.each{|attr| a.__send__("#{attr}=", asset_categorization_item.__send__("#{attr}"))}
        [:activated, :accepted, :published, :is_specific_fund, :is_tariff_free, :is_vat_free].each{|attr| a.__send__("#{attr}=", false)}
        a.salvage = a.original_cost
        a.accessory_status = AccessoryStatusType[:to_be_defined][:weight]
      end
    end
  end

  def category_description; "#{category.name} - #{sub_category.name}"; end
  def accessories_defined?; accessory_status != AccessoryStatusType[:to_be_defined][:weight]; end
  def allocated?; !allocations.empty?; end

  def no_accessories!(*args)
    user, _ = args
    raise NoMethodError, I18n.t('') unless accessory_status == AccessoryStatusType[:to_be_defined][:weight]
    self.updated_by_id = user.id
    self.accessory_status = AccessoryStatusType[:to_be_defined][:none]
    accessories.each{|acc| acc.disable_by(user);}
    save
  end
end
