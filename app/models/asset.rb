class Asset < ActiveRecord::Base
  attr_accessible :accepted, :accepted_at, :accepted_by_id, :activated, :activated_at, :activated_by_id, :asset_name, :asset_no, :brand, :category_id, :created_by_id, :is_specific_fund, :is_tariff_free, :is_vat_free, :model, :original_cost, :published, :published_at, :salvage, :salvage_rate, :serial_no, :sub_category_id, :tax_preference_id, :updated_by_id, :vat, :vat_rate

  belongs_to :accepted_by, :class_name => "User"
  belongs_to :activated_by, :class_name => "User"
  belongs_to :category, :class_name => "Category"
  belongs_to :sub_category, :class_name => "SubCategory"
  belongs_to :created_by, :class_name => "User"
  belongs_to :tax_preference, :class_name => "TaxPreference"
  belongs_to :updated_by, :class_name => "User"

  has_many :transfering_assets, :class_name => "TransferingAsset", :foreign_key => "refer_id_to"
  has_many :asset_transfers, :class_name => "AssetTransfer", :through => :transfering_assets
  has_many :allocations, :class_name => "AssetAllocation", :foreign_key => "asset_id", :conditions => {:enabled => true}

  scope :search, lambda { |search|
  }

  def category_description; "#{category.name} - #{sub_category.name}"; end
end
