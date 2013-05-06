class SubCategory < MasterData
  attr_accessible :code, :name, :enabled, :parent_id

  belongs_to :parent, :class_name => "Category", :foreign_key => "parent_id"

  has_many :assets, :class_name => "Asset", :foreign_key => "category_id" 

  def to_s; "#{code} #{name}"; end

end
