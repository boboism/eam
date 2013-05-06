class AssetTransfer < ActiveRecord::Base
  attr_accessible :approved_at, :approved_by_id, :confirmed_at, :confirmed_by_id, :created_by_id, :document_status, :effective_date, :published, :published_at, :rejected_at, :rejected_by_id, :submitted_at, :submitted_by_id, :updated_by_id

  has_many :transfering_assets, :class_name => "TransferingAsset", :foreign_key => "refer_id_from"
  accepts_nested_attributes_for :transfering_assets
  has_many :asset_transfer_item_froms, :class_name => "AssetTransferItemFrom", :through => :transfering_assets
  has_many :asset_transfer_item_tos, :class_name => "AssetTransferItemTo", :through => :transfering_assets

  scope :search, lambda{|search|
  }
end
