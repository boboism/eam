class CostCenter < MasterData
  attr_accessible :code, :name, :description, :parent_id, :created_by_id, :updated_by_id, :enabled

  validates :code, :presence => true, :uniqueness => true
  validates :name, :presence => true

  belongs_to :parent, :class_name => "CostCenter", :foreign_key => "parent_id"
  has_many :children, :class_name => "CostCenter", :foreign_key => "parent_id"

  scope :enabled, lambda{ where(:enabled => true) }

  def self.selectable
    enabled.collect{|c| ["#{c.code} #{c.name}", c.id]}
  end
end
