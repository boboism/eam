class AssetCategorizationItem < ActiveRecord::Base
  attr_accessible :amount, :asset_name, :asset_categorization_id, :contract_no, :conversion_rate, :quantity, :remark, :supplier, :usage, :category_id, :sub_category_id, :asset_no, :brand, :model, :specification, :serial_no, :purchase_no, :arrival_date, :design_company, :construction_company, :construction_date_from, :construction_date_to, :asset_id

  AssetAttributes = [:original_cost, :asset_name, :contract_no, :remark, :supplier, :category_id, :sub_category_id, :asset_no, :brand, :model, :specification, :serial_no, :purchase_no, :arrival_date, :design_company, :construction_company, :construction_date_from, :construction_date_to]

  validates :amount, :numericality => {:greater_than_or_equal_to => 0}
  validates :conversion_rate, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 1}
  validates :asset_name, :presence => true
  #validates :asset_categorization_id, :presence => true
  #validates :quantity, :numericality => {:greater_than_or_equal_to => 0}
  validates :category_id, :sub_category_id, :presence => true
  validates :asset_no, :asset_id, :presence => true, :if => lambda{|item| 
    (ac = item.asset_categorization) && ac.confirmed && !ac.approved 
  }
  validates :serial_no, :presence => true
  validates :arrival_date, :presence => true
  validates :construction_date_from, :construction_date_to, :presence => true, :unless => "construction_company.blank?"

  belongs_to :asset_categorization, :class_name => "AssetCategorization", :foreign_key => "asset_categorization_id", :counter_cache => :items_count
  belongs_to :sub_category, :class_name => "SubCategory", :foreign_key => "sub_category_id"
  belongs_to :category, :class_name => "Category", :foreign_key => "category_id"
  belongs_to :asset, :class_name => "Asset", :foreign_key => "asset_id"

  before_validation :sync_category_id
  def sync_category_id
    if sub_cat = SubCategory.where(:id => self.sub_category_id).first
      self.category_id = sub_cat.parent_id
    end
  end

  def original_cost; amount * conversion_rate; end

end
