class SpecificInvestment < MasterData
  attr_accessible :code, :name, :description, :enabled, :created_by_id, :updated_by_id
  validates :code, :presence => true, :uniqueness => true
  validates :name, :presence => true

  def self.selectable
    enabled.collect{|i| [i.name, i.id]}
  end
end
