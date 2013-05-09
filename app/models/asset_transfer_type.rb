class AssetTransferType < MasterData
  attr_accessible :code, :name, :enabled, :created_by_id, :updated_by_id

  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
end
