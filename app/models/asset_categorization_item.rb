class AssetCategorizationItem < ActiveRecord::Base
  attr_accessible :asset_name, :asset_categorization_id, :contract_no, :remark, :supplier, :usage, :sub_category_id, :asset_no, :brand, :model, :specification, :serial_no, :purchase_no, :arrival_date, :design_company, :construction_company, :construction_date_from, :construction_date_to, :asset_id, :allocation_propotion, :cost_center_id, :management_department_id, :warranty_date_from, :warranty_period, :store_location_id, :responsible_by, :original_cost, :vat, :vat_rate, :is_energy_saving, :is_env_protection, :is_research_use, :is_safety_production, :construction_period_id, :specific_investment_id, :accessory_status

  AssetAttributes = [:original_cost, :asset_name, :contract_no, :remark, :supplier, :sub_category_id, :asset_no, :brand, :model, :specification, :serial_no, :purchase_no, :arrival_date, :design_company, :construction_company, :construction_date_from, :construction_date_to, :vat, :vat_rate, :is_energy_saving, :is_env_protection, :is_research_use, :is_safety_production, :accessory_status]

  validates :original_cost, :numericality => {:greater_than_or_equal_to => 0}
  validates :asset_name, :presence => true
  validates :sub_category_id, :cost_center_id, :management_department_id, :store_location_id, :construction_period_id, :presence => true
  validates :asset_no, :asset_id, :presence => true, :if => lambda{ |item| (ac = item.asset_categorization) && ac.confirmed && !ac.approved }
  validates :serial_no, :presence => true
  validates :arrival_date, :presence => true
  validates :construction_date_from, :presence => true, :date => {:before => :construction_date_to}, :unless => "construction_company.blank?"
  validates :construction_date_to, :presence => true, :unless => "construction_company.blank?"
  validates :warranty_date_from, :presence => true, :date => {:before => :warranty_date_to}
  validates :warranty_date_to, :presence => true
  validates :warranty_period, :presence => true, :numericality => {:greater_than_or_equal_to => 0}

  belongs_to :asset_categorization, :class_name => "AssetCategorization", :foreign_key => "asset_categorization_id", :counter_cache => :items_count
  belongs_to :asset, :class_name => "Asset", :foreign_key => "asset_id"
  belongs_to :cost_center, :class_name => "CostCenter", :foreign_key => "cost_center_id"
  belongs_to :sub_category, :class_name => "SubCategory", :foreign_key => "sub_category_id"
  belongs_to :management_department, :class_name => "Department", :foreign_key => "management_department_id"
  belongs_to :store_location, :class_name => "StoreLocation", :foreign_key => "store_location_id"
  belongs_to :construction_period, :class_name => "ConstructionPeriod", :foreign_key => "construction_period_id"
  belongs_to :specific_investment, :class_name => "SpecificInvestment", :foreign_key => "specific_investment_id"

  before_validation :calculate_warranty_date_to

  def cost_center_code=(value)
    self.cost_center_id = CostCenter.where{(code == my{value}) | (name == my{value})}.first.id
  end

  def sub_category_code=(value)
    self.sub_category_id = SubCategory.where{(code == my{value}) | (name == my{value})}.first.id
  end

  def management_department_code=(value)
    self.management_department_id = Department.where{(code == my{value}) | (name == my{value})}.first.id
  end
  
  def store_location_code=(value)
    self.store_location_id = StoreLocation.where{(code == my{value}) | (name == my{value})}.first.id
  end

  def construction_period_code=(value)
    self.construction_period_id = ConstructionPeriod.where{(code == my{value}) | (name == my{value})}.first.id
  end

  def specific_investment_code=(value)
    self.specific_investment_id = SpecificInvestment.where{(code == my{value}) | (name == my{value})}.first.id
  end

  def calculate_warranty_date_to
    if warranty_period && warranty_date_from && warranty_period == warranty_period.abs 
      self.warranty_date_to = warranty_period.since(warranty_date_from) 
    end
  end
  private :calculate_warranty_date_to

end
