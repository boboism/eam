class CostCenter < MasterData
  attr_accessible :code, :name, :description, :parent_id, :created_by_id, :updated_by_id, :enabled

  validates :code, :presence => true, :uniqueness => true
  validates :name, :presence => true

  belongs_to :parent, :class_name => "CostCenter", :foreign_key => "parent_id"
  has_many :children, :class_name => "CostCenter", :foreign_key => "parent_id"

  has_many :manageable_cost_center_relationships, class_name: "ModelRelationship", as: :refer_to, dependent: :destroy, conditions: { type: "UserManageableCostCenter" }
  has_many :managed_users, through: :manageable_cost_center_relationships, source: :refer_from, source_type: "User"

  scope :enabled, lambda{ where(:enabled => true) }

  def self.selectable
    enabled.collect{|c| ["#{c.code} #{c.name}", c.id]}
  end
end
