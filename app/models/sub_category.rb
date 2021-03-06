class SubCategory < MasterData
  attr_accessible :code, :name, :enabled, :parent_id, :profiles
  serialize :profiles
  validates :code, :presence => true, :uniqueness => true
  validates :name, :presence => true

  belongs_to :parent, :class_name => "Category", :foreign_key => "parent_id"

  has_many :assets, :class_name => "Asset", :foreign_key => "category_id" 

  def to_s; "#{name}"; end

  def number_pooling_prefix; parent ? "#{parent.code.strip}#{code.strip}" : "";end

  def self.selectable
    includes{parent}.enabled.collect{|c| ["#{c.parent.code}#{c.code} #{c.parent.name}-#{c.name}", c.id]}
  end

  AssetNumberPooling::StatusType.each do |key, value|
    class_eval <<-END
      def #{key}_numbers
        AssetNumberPooling.where{(status == #{value[:weight]}) & (serial =~ my{number_pooling_prefix+"%"})}.select{serial}.map(&:serial)
      end
    END
  end

end
