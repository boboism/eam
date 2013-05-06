class ModelRelationship < ActiveRecord::Base
  attr_accessible :created_by_id, :refer_id_from, :refer_id_to, :updated_by_id
end
