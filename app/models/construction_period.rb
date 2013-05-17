class ConstructionPeriod < MasterData
  attr_accessible :code, :name, :descrition, :enabled, :created_by_id, :updated_by_id
  validates :code, :presence => true, :uniqueness => true
  validates :name, :presence => true
  validates :enabled, :presence => true

  def self.selectable
    enabled.collect{|p| [p.name, p.id]}
  end
end
