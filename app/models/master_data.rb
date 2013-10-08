class MasterData < ActiveRecord::Base
  attr_accessible :code, :description, :name, :parent_id, :type, :created_by_id, :updated_by_id, :enabled

  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"

  scope :enabled, lambda{ where(:enabled => true) }

  scope :search, lambda{|params={}|
    params ||= {}
    master_datas = unscoped.where{type.in(my{types.map(&:last)})}
    if params[:text].present?
      if master_data_types = types.select{|item| item.first =~ %r"#{params[:text]}"}.map{|item| item.last} and master_data_types.size > 0
        master_datas = master_datas.where{type.in master_data_types}
      else
        master_datas = master_datas.where{(name.like("%#{params[:text]}%") | code.like("%#{params[:text]}"))}
      end
    end
    master_datas
  }

  def self.types
    %w(Category SubCategory ConstructionPeriod CostCenter Department SpecificInvestment TaxPreference).map{|klass|
      [klass.constantize.model_name.human, klass]
    }
  end

  def self.selectable
    enabled.collect{|c| ["#{c.type.constantize.model_name.human} #{c.code} #{c.name}", c.id]}
  end

  def to_s;"#{code} #{name}";end

  def enable!(user)
    raise NoMethodError, I18n.t(".activerecord.errors.models.master_data.attributes.already_enabled")  if enabled
    update_attributes(:enabled => true, updated_by_id: user.id) 
  end

  def disable!(user)
    raise NoMethodError, I18n.t(".activerecord.errors.models.master_data.attributes.already_disabled")  unless enabled
    update_attributes(:enabled => false, updated_by_id: user.id) 
  end

end
