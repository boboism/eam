class AssetCategorization < ActiveRecord::Base
  CategorizeType = {
    :purchase_via_oa => {:weight => (1 << 0), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.purchase_via_oa")}, 
    :purchase => {:weight => (1 << 1), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.purchase")}, 
    :financial_lease => {:weight => (1 << 2), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.financial_lease")}, 
    :commercial_lease => {:weight => (1 << 3), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.commercial_lease")},
    :borrow => {:weight => (1 << 4), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.borrow")},
    :free => {:weight => (1 << 5), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.free")},
    :inventory_profit => {:weight => (1 << 6), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.inventory_profit")},
    :other => {:weight => (1 << 7), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.other")}
  }
  attr_accessible :approved, :approved_at, :approved_by_id, :categorize_type, :confirmed, :confirmed_at, :confirmed_by_id, :created_by_id, :submitted, :submitted_at, :submitted_by_id, :updated_by_id, :doc_status, :asset_categorization_items_attributes, :asset_attributes

  validates :approved_at, :approved_by_id, :presence => true, :if => :approved
  validates :confirmed_at, :confirmed_by_id, :presence => true, :if => :confirmed
  validates :submitted_at, :submitted_by_id, :presence => true, :if => :submitted
  validates :created_by_id, :updated_by_id, :presence => true
  validates :categorize_type, :presence => true, :inclusion => CategorizeType.values.collect{|v| v[:weight]}
  #validates :doc_status, :presence => true
 
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
  belongs_to :submitted_by, :class_name => "User", :foreign_key => "submitted_by_id"
  belongs_to :confirmed_by, :class_name => "User", :foreign_key => "confirmed_by_id"
  belongs_to :approved_by, :class_name => "User", :foreign_key => "approved_by_id"

  has_many :asset_categorization_items, :class_name => "AssetCategorizationItem", :dependent => :destroy
  accepts_nested_attributes_for :asset_categorization_items
  scope :search, lambda{|search|}

  def categorize_type_name;CategorizeType.select{|k,v| v[:weight] == categorize_type}.first.last[:description];end

  def submit!(user)
    self.transaction do
      raise I18n.t("activerecord.attributes.asset_categorization.transactions.already_submitted") if submitted?
      update_attributes!(:submitted => true, :submitted_by_id => user.id, :submitted_at => DateTime.now, :updated_by_id => user.id)  
    end
  end

  def confirm!(user)
    self.transaction do 
      raise I18n.t("activerecord.attributes.asset_categorization.transactions.already_confirmed") if confirmed?
      update_attributes!(:confirmed => true, :confirmed_by_id => user.id, :confirmed_at => DateTime.now, :updated_by_id => user.id)  
    end
  end

  def approve!(user)
    self.transaction do 
      asset_categorization_items.each do |item|
        asset_no_in_pool = AssetNumberPooling.next(item.sub_category)
        item.asset_no = asset_no_in_pool.serial
        # create a asset
        asset = Asset.new_by_asset_categorization_item(item, user)
        p asset.errors.full_messages
        p asset.save!
        item.asset = asset
        #asset_no_in_pool.owned_by!(asset)
      end
      #update_attributes!(:approved => true, :approved_by_id => user.id, :approved_at => DateTime.now, :updated_by_id => user.id)
    end
  end

end
