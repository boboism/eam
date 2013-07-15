class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  has_many :accepted_assets, :class_name => "Asset", :foreign_key => "accepted_by_id"
  has_many :activated_assets, :class_name => "Asset", :foreign_key => "activated_by_id"
  has_many :created_assets, :class_name => "Asset", :foreign_key => "created_by_id"
  has_many :updated_assets, :class_name => "Asset", :foreign_key => "updated_by_id"

  has_many :accessory_adjustments, class_name: "AccessoryAdjustment", foreign_key: "created_by_id"
  has_many :submitted_accessory_adjustments, class_name: "AccessoryAdjustment", foreign_key: "submitted_by_id"
  has_many :confirmed_accessory_adjustments, class_name: "AccessoryAdjustment", foreign_key: "confirmed_by_id"
  has_many :approved_accessory_adjustments, class_name: "AccessoryAdjustment", foreign_key: "approved_by_id"

  has_many :asset_transfers, class_name: "AccessoryAdjustment", foreign_key: "created_by_id"
  has_many :submitted_asset_transfers, class_name: "AccessoryAdjustment", foreign_key: "submitted_by_id"
  has_many :confirmed_asset_transfers, class_name: "AccessoryAdjustment", foreign_key: "confirmed_by_id"
  has_many :approved_asset_transfers, class_name: "AccessoryAdjustment", foreign_key: "approved_by_id"

  has_many :asset_info_adjustments, class_name: "AssetInfoAdjustment", foreign_key: "created_by_id"
  has_many :submitted_asset_info_adjustments, class_name: "AssetInfoAdjustment", foreign_key: "submitted_by_id"
  has_many :confirmed_asset_info_adjustments, class_name: "AssetInfoAdjustment", foreign_key: "confirmed_by_id"
  has_many :approved_asset_info_adjustments, class_name: "AssetInfoAdjustment", foreign_key: "approved_by_id"

  has_many :asset_cost_adjustments, class_name: "AssetCostAdjustment", foreign_key: "created_by_id"
  has_many :submitted_asset_cost_adjustments, class_name: "AssetCostAdjustment", foreign_key: "submitted_by_id"
  has_many :confirmed_asset_cost_adjustments, class_name: "AssetCostAdjustment", foreign_key: "confirmed_by_id"
  has_many :approved_asset_cost_adjustments, class_name: "AssetCostAdjustment", foreign_key: "approved_by_id"

  def to_s; name; end
  
end
