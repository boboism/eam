class Category < MasterData
  attr_accessible :code, :name, :enabled, :description
  validates :code, :presence => true, :uniqueness => true
  validates :name, :presence => true
  validates :enabled, :presence => true

  has_many :children, :class_name => "SubCategory", :foreign_key => "parent_id"
  has_many :assets, :class_name => "Asset", :foreign_key => "category_id"

  def to_s; "#{code} #{name}"; end

end
