class MasterData < ActiveRecord::Base
  attr_accessible :code, :description, :name, :parent_id, :type, :created_by_id, :updated_by_id, :enabled

  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"

  scope :enabled, lambda{ where(:enabled => true) }

  def self.selectable
    enabled.collect{|c| ["#{c.code} #{c.name}", c.id]}
  end

end
