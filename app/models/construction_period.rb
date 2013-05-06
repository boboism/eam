class ConstructionPeriod < MasterData
  attr_accessible :code, :name, :descrition, :enabled, :created_by_id, :updated_by_id

  def self.selectable
    enabled.collect{|p| [p.name, p.id]}
  end
end
