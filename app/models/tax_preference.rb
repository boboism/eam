class TaxPreference < MasterData
  attr_accessible :code, :name, :enabled, :description
  
  validates :code, :presence => true, :uniqueness => true
  validates :name, :presence => true

  has_many :assets, :class_name => "Asset", :foreign_key => "tax_preference_id"

  def self.selectable
    enabled.order("id").collect{|c| ["#{c.name}", c.id]}
  end

  def to_s; "#{name}"; end
end
