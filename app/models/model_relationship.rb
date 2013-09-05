class ModelRelationship < ActiveRecord::Base
  attr_accessible :refer_from_id, :refer_from_status, :refer_from_type, :refer_to_id, :refer_to_status, :refer_to_type, :type
  belongs_to :refer_to,   polymorphic: true
  belongs_to :refer_from, polymorphic: true
end
