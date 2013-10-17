class AssetCategorization < ActiveRecord::Base
  CategorizeType = {
    :purchase_via_oa  => {:weight => (1 << 0), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.purchase_via_oa")},
    :purchase         => {:weight => (1 << 1), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.purchase")},
    :financial_lease  => {:weight => (1 << 2), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.financial_lease")},
    :commercial_lease => {:weight => (1 << 3), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.commercial_lease")},
    :borrow           => {:weight => (1 << 4), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.borrow")},
    :free             => {:weight => (1 << 5), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.free")},
    :inventory_profit => {:weight => (1 << 6), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.inventory_profit")},
    :other            => {:weight => (1 << 7), :description => I18n.t("activerecord.attributes.asset_categorization.categorize_types.other")}
  }
  attr_accessible :approved, :approved_at, :approved_by_id, :categorize_type, :confirmed, :confirmed_at, :confirmed_by_id, :created_by_id, :submitted, :submitted_at, :submitted_by_id, :updated_by_id, :doc_status, :asset_categorization_items_attributes, :asset_attributes, :number_arranged, :number_arranged_at, :number_arranged_by_id

  with_options :if => :approved do |ac|
    ac.validates :approved_at, :approved_by_id, :presence => true, :if => :approved
  end
  with_options :if => :confirmed do |ac|
    validates :confirmed_at, :confirmed_by_id, :presence => true, :if => :confirmed
  end
  with_options :if => :submitted do |ac|
    validates :submitted_at, :submitted_by_id, :presence => true, :if => :submitted
  end
  validates :created_by_id, :updated_by_id, :presence => true
  validates :categorize_type, :presence => true, :inclusion => CategorizeType.values.collect{|v| v[:weight]}
  #validates :doc_status, :presence => true

  with_options :class_name => "User" do |ac|
    ac.belongs_to :created_by,   :foreign_key => "created_by_id"
    ac.belongs_to :updated_by,   :foreign_key => "updated_by_id"
    ac.belongs_to :submitted_by, :foreign_key => "submitted_by_id"
    ac.belongs_to :confirmed_by, :foreign_key => "confirmed_by_id"
    ac.belongs_to :approved_by,  :foreign_key => "approved_by_id"
    ac.belongs_to :number_arranged_by,  :foreign_key => "number_arranged_by_id"
  end

  has_many :asset_categorization_items, :class_name => "AssetCategorizationItem", :dependent => :destroy
  accepts_nested_attributes_for :asset_categorization_items

  has_many :reject_reason_relationships, class_name: "ModelRelationship", as: :refer_from, dependent: :destroy
  has_many :reject_reasons, through: :reject_reason_relationships, source: :refer_to, source_type: "MasterData", conditions: { type: "AssetCategorizationRejectReason" }                

  scope :search, lambda{|search|
    search ||= {}
    text, criteria = search[:text], scoped
    criteria = criteria.where{(id == text.to_i)} unless text.blank?
  }

  # import & save!
  def self.import!(file)
    asset_cat = import(file)
    asset_cat.save!
  end

  # import items from xls/xlsx/csv
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    asset_cat = AssetCategorization.new

    # uploaded xls/xlsx has 2 header rows, 1st row is in english which titled attr_names in activerecord,
    # and the 2nd rows is in chinese desc for the end user
    header = spreadsheet.row(1)
    (3..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      asset_cat.asset_categorization_items << AssetCategorizationItem.new(row.to_hash.slice(*AssetCategorizationItem.accessible_attributes))
    end
    asset_cat
  end

  # open xls/xlsx/csv
  def self.open_spreadsheet(file)
    case File.extname(file.original_name)
    when '.csv' then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise I18n.t('activerecord.errors.exceptions.unknown_filetype', filetype: file.original_filename)
    end
  end

  def categorize_type_name;CategorizeType.select{|k,v| v[:weight] == categorize_type}.first.last[:description];end

  def submit!(user)
    errors.add(:submitted, I18n.t("activerecord.attributes.asset_categorization.transactions.already_submitted", :at => submitted_at, :by => submitted_by)) && return if submitted?
    self.transaction do
      update_attributes(:submitted => true, :submitted_by_id => user.id, :submitted_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def confirm!(user)
    errors.add(:confirmed, I18n.t("activerecord.attributes.asset_categorization.transactions.already_confirmed", :at => confirmed_at, :by => confirmed_by)) && return if confirmed?
    self.transaction do
      update_attributes(:confirmed => true, :confirmed_by_id => user.id, :confirmed_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def reject!(*args)
    raise NoMethedError, I18n.t("activerecord.errors.models.asset_categorization.already_approved") if approved?
    user, reason, _ = args
    time_now = Time.now
    self.transaction do
      self.reject_reasons << AssetCategorizationRejectReason.new(code: "#{self.class.name}#{time_now.to_i}",
                                                                 name: "[#{self.class.name}] [#{current_status}] [#{time_now}] [#{id}] [#{user.id}]",
                                                                 asset_categorization_id: self.id,
                                                                 description: reason,
                                                                 created_by_id: user.id,
                                                                 updated_by_id: user.id)
      return_asset_no_to_pool! 
      clear_approval_info!(user.id) 
    end
  end

  def approve!(user)
    errors.add(:approved, I18n.t("activerecord.attributes.asset_categorization.transactions.already_approved", :at => approved_at, :by => approved_by)) && return if approved?
    self.transaction do
      update_attributes(:approved => true, :approved_by_id => user.id, :approved_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def arrange_number!(user)
    errors.add(:number_arranged, I18n.t("activerecord.attributes.asset_categorization.transactions.already_arranged_number", :at => number_arranged_at, :by => number_arranged_by)) && return if number_arranged?
    self.transaction do
      asset_categorization_items.each do |item|
        asset_no_in_pool = AssetNumberPooling.next(item.sub_category)
        item.asset_no = asset_no_in_pool.serial
        # create a asset
        asset = Asset.new_by_asset_categorization_item(item, user)
        asset.save
        item.asset_id = asset.id
        asset_no_in_pool.taken_by!(asset)
      end
      update_attributes(:number_arranged => true, :number_arranged_by_id => user.id, :number_arranged_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def clear_approval_info(*args)
    user_id = args.first
    self.attributes = {:submitted => false,
                       :confirmed => false,
                       :number_arranged => false,
                       :submitted_by_id => nil,
                       :submitted_at => nil,
                       :confirmed_by_id => nil,
                       :confirmed_at => nil,
                       :number_arranged_at => nil,
                       :number_arranged_by_id => nil,
                       :updated_by_id => user_id}
  end

  def clear_approval_info!(*args)
    clear_approval_info(*args) && save!
  end

  def return_asset_no_to_pool!
    if number_arranged?
      asset_categorization_items.each do |item|
        AssetNumberPooling.return_by!(item.asset)
        item.asset.destroy
        item.attributes = {asset_no: nil, asset_id: nil}
      end
    end
  end

  def current_status
    [:approved, :confirmed, :number_arranged, :submitted].select{|item| __send__(item) }.first.to_s.upcase
  end

end
