class SpecificInvestment < MasterData
  attr_accessible :code, :name, :description, :enabled, :created_by_id, :updated_by_id

  def self.selectable
    enabled.collect{|i| [i.name, i.id]}
  end
end
