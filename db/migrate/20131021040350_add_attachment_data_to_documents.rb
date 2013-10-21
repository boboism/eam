class AddAttachmentDataToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.attachment :data
    end
  end

  def self.down
    drop_attached_file :documents, :data
  end
end
