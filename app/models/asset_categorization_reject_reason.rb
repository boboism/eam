class AssetCategorizationRejectReason < MasterData
  attr_accessible :code, :description, :name, :parent_id, :asset_categorization_id
  alias_attribute :asset_categorization_id, :parent_id
  belongs_to :asset_categorization, :foreign_key => "parent_id", :class_name => "AssetCategorization"
end
