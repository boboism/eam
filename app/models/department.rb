class Department < MasterData
  attr_accessible :code, :name, :description, :parent_id, :created_by_id, :updated_by_id, :enabled

  belongs_to :parent, :class_name => "Department", :foreign_key => "parent_id"
  has_many :children, :class_name => "Department", :foreign_key => "parent_id"

  scope :enabled, lambda{ where(:enabled => true) }
end
