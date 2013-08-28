class Category < MasterData
  attr_accessible :code, :name, :enabled, :description, :profiles
  serialize :profiles
  validates :code, :presence => true, :uniqueness => true
  validates :name, :presence => true

  has_many :children, :class_name => "SubCategory", :foreign_key => "parent_id"
  has_many :assets, :class_name => "Asset", :foreign_key => "category_id"

  def to_s; "#{code} #{name}"; end

end
