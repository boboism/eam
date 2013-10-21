class Document < ActiveRecord::Base
  attr_accessible :description, :documentable_id, :documentable_type, :status, :type
end
