class TaxPreference < MasterData
  attr_accessible :code, :name, :enabled

  has_many :assets, :class_name => "Asset", :foreign_key => "tax_preference_id"

  def to_s; "#{name}"; end
end
