class Asset < ActiveRecord::Base
  attr_accessible :accepted, :accepted_at, :accepted_by_id, :activated, :activated_at, :activated_by_id, :asset_name, :asset_no, :brand, :category_id, :created_by_id, :is_specific_fund, :is_tariff_free, :is_vat_free, :model, :original_cost, :published, :published_at, :salvage, :salvage_rate, :serial_no, :sub_category_id, :tax_preference_id, :updated_by_id, :vat, :vat_rate, :supplier, :specification

  validates :accepted, :presence => true
  validates :accepted_by_id, :presence => true, :if => :accepted
  validates :accepted_at, :presence => true, :if => :accepted
  validates :activated, :presence => true
  validates :activated_by_id, :presence => true, :if => :activated
  validates :activated_at, :presence => true, :if => :activated
  validates :asset_name, :presence => true, :if => :activated
  validates :category_id, :presence => true, :if => :activated
  validates :created_by_id, :presence => true
  validates :is_specific_fund, :presence => true
  validates :is_tariff_free, :presence => true
  validates :is_vat_free, :presence => true
  validates :original_cost, :presence => true, :numericality => {:greater_than => 0}
  validates :published, :presence => true
  validates :published_at, :presence => true, :if => :published
  validates :salvage, :presence => true, :numericality => {:greater_than => 0}, :if => :accepted
  validates :salvage_rate, :presence => true, :numericality => {:greater_than_or_equal_to => 0}, :if => :accepted
  validates :serial_no, :presence => true
  validates :sub_category_id, :presence => true, :if => :accepted
  validates :tax_preference_id, :presence => true, :if => :accepted
  validates :updated_by_id, :presence => true
  validates :vat_rate, :presence => true, :numericality => {:greater_than_or_equal_to => 0}

  belongs_to :accepted_by, :class_name => "User"
  belongs_to :activated_by, :class_name => "User"
  belongs_to :category, :class_name => "Category"
  belongs_to :sub_category, :class_name => "SubCategory"
  belongs_to :created_by, :class_name => "User"
  belongs_to :tax_preference, :class_name => "TaxPreference"
  belongs_to :updated_by, :class_name => "User"

  has_one :asset_categorization_item, :class_name => "AssetCategorizationItem", :foreign_key => "asset_id"

  has_many :transfering_assets, :class_name => "TransferingAsset", :foreign_key => "refer_id_to"
  has_many :asset_transfers, :class_name => "AssetTransfer", :through => :transfering_assets
  has_many :allocations, :class_name => "AssetAllocation", :foreign_key => "asset_id", :conditions => {:enabled => true}


  scope :search, lambda { |search|
  }

  class << self
    def new_by_asset_categorization_item(asset_categorization_item, user)
      new(:created_by_id => user.id, :updated_by_id => user.id) do |a|
        AssetCategorizationItem::AssetAttributes.each{|attr| a.__send__("#{attr}=", asset_categorization_item.__send__("#{attr}"))}
        [:activated, :accepted, :published, :is_specific_fund, :is_tariff_free, :is_vat_free].each{|attr| a.__send__("#{attr}=", false)}
      end
    end
  end

  def category_description; "#{category.name} - #{sub_category.name}"; end
end
