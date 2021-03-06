require_dependency "#{Rails.root}/extras/eam_extension/array.rb"

class AssetTransfer < ActiveRecord::Base
  attr_accessible :approved_at, :approved_by_id, :confirmed_at, :confirmed_by_id, :created_by_id, :effective_date, :published, :published_at, :rejected_at, :rejected_by_id, :submitted_at, :submitted_by_id, :updated_by_id, :transfering_assets_attributes, :transfer_type, :submitted, :approved, :confirmed

  belongs_to :approved_by, :class_name => "User", :foreign_key => "approved_by_id"
  belongs_to :confirmed_by, :class_name => "User", :foreign_key => "confirmed_by_id"
  belongs_to :submitted_by, :class_name => "User", :foreign_key => "submitted_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"


  # association between transfer order & transfer_items and incase of the multi-asset transfer business case
  has_many :transfering_assets, :class_name => "TransferingAsset", :foreign_key => "refer_from_id", :dependent => :destroy
  accepts_nested_attributes_for :transfering_assets
  has_many :assets, :class_name => "Asset", :through => :transfering_assets
  has_many :asset_transfer_item_froms, :class_name => "AssetTranferItemFrom", :through => :transfering_assets
  has_many :asset_transfer_item_tos, :class_name => "AssetTranferItemTo", :through => :transfering_assets

  # transfer items of the tranfer order, association of transfering assets 
  # total quantity of each transfering asset's transfer items(both froms and tos) should be 1
  with_options :through => :transfering_assets do |assoc|
    assoc.has_many :asset_transfer_item_froms, :class_name => "AssetTransferItemFrom"
    assoc.has_many :asset_transfer_item_tos,   :class_name => "AssetTransferItemTo"
  end

  validates :effective_date, :date => {:after => Date.current}
  validates :created_by, :updated_by_id, :presence => true
  validates :updated_by, :updated_by_id, :presence => true
  #validates :asset_transfer_item_tos, presence: true
  #validate :validate_item_tos_total_quantity_euqals_to_one

  # |------------------------------|------|------------------------|
  # |TRANSFER TYPE                 |WEIGHT|MATCH CASE              |
  # |------------------------------|------|------------------------|
  # |responsible_transfer          |1     |responsible_by          |
  # |------------------------------|------|------------------------|
  # |management_department_transfer|2     |management_department_id|
  # |------------------------------|------|------------------------|
  # |cost_center_transfer          |4     |cost_center_id          |
  # |------------------------------|------|------------------------|
  TransferType = {:responsible_transfer           => {:weight => (1 << 0), :match => :responsible_by, :description => I18n.t("activerecord.attributes.asset_transfer.transfer_types.responsible_transfer")}, 
                  :management_department_transfer => {:weight => (1 << 1), :match => :management_department_id, :description => I18n.t("activerecord.attributes.asset_transfer.transfer_types.management_department_transfer")}, 
                  :cost_center_transfer           => {:weight => (1 << 2), :match => :cost_center_id, :description => I18n.t("activerecord.attributes.asset_transfer.transfer_types.management_department_transfer")}}

  scope :search, lambda{ |search={}|
    search ||= {}
    if search[:text]
      joins{transfering_assets.asset}.where{transfering_assets.asset.asset_no =~ "%#{search[:text]}%"} 
    end
  }

  class << self
    def new_by_asset_and_user(targets = [], user = nil)
      # by default business case, only one asset will be transfered each time,
      # but incase of clients want a multi-assets transfer function,
      # make it to an array(Asset), so that can satisfy the needs of 
      # business case change.
      targets, default_attrs = Array(targets), {:created_by_id => user.id, :updated_by_id => user.id}
      trans_to_attrs = default_attrs.merge({construction_period_id:   ConstructionPeriod.first.try(:id),
                                            cost_center_id:           CostCenter.first.try(:id),
                                            management_department_id: Department.first.try(:id),
                                            specific_investment_id:   SpecificInvestment.first.try(:id)})
      return new(default_attrs.merge(:submitted => false, :confirmed => false, :approved => false)) do |instance|
        instance.transfering_assets << targets.collect do |asset|
          TransferingAsset.new(default_attrs.merge(:asset_id => asset.id)) do |tr|
            # initialize trans from
            tr.asset_transfer_item_froms << tr.asset.allocations.collect do |alloc|
              AssetTransferItemFrom.new_by_asset_allocation(alloc, default_attrs)
            end 
            # initialize trans to
            # if is the first time tranfer, auto init a empty trans_to_item with quantity = 1
            # else copy the trans_from_items
            if tr.asset_transfer_item_froms.empty?
              tr.asset_transfer_item_tos << AssetTransferItemTo.new(default_attrs.merge(:allocation_propotion => 1))
            else
              tr.asset_transfer_item_tos << tr.asset_transfer_item_froms.collect do |trans_fm|
                AssetTransferItemTo.new_by_asset_transfer_item_from(trans_fm, trans_to_attrs) 
              end
            end
            logger.debug "fms: #{tr.asset_transfer_item_froms.count}"
            logger.debug "tos: #{tr.asset_transfer_item_tos.count}"
          end 
        end
      end
    end

  end

  # make changes to assets' allocations from tranfer_item_tos
  def apply_tranfer_items_to_asset(user_id = nil)
    # return if the allocations of the assets are NOT the same as the transfering items 
    return false if transfering_assets.any?{|tr| !(tr.asset.allocations.collect(&:id) ^ tr.asset_transfer_item_froms.collect(&:id)).empty?  }
    default_attrs = {:created_by_id => user_id, :updated_by_id => user_id}
    # 1st: disable the former allocations
    # 2nd: new allocations by trans_tos
    ActiveRecord::Base.transaction do
      transfering_assets.collect do |tr|
        tr.asset.allocations.each{|alloc| alloc.disabled!(user_id)}
        tr.asset.reload
        tr.asset.allocations << tr.asset_transfer_item_tos.collect do |trans_to|
          AssetAllocation.new_by_transfer_item_to(trans_to, default_attrs)
        end
        tr.save
      end.all?
    end
  end

  # show the tranfer_type_description for html show out
  def transfer_type_description_list
    transfer_types.collect{|key, value| value[:description]} 
  end

  def transfer_types
    weight = Array(transfer_type.to_s(2).reverse.chars) # reverse the binary codes 
    weight = weight.zip((0...weight.size)).collect{|item| item.first.to_i * item.last} # calculate the weight of each 
    TransferType.select{|key, value| weight.include?(value[:weight])} # collect weight only avaliable under the TransferType's weights
  end

  # update the transfer_type automatically while transfer items have changed
  before_save :update_transfer_type
  def update_transfer_type
    unless submitted?
      self.transfer_type = TransferType.keys.inject(0) do |acc, trans_type| 
        # accumulate each bit of the weight
        acc |= match_transfer_type?(trans_type) ? TransferType[trans_type][:weight] : 0
      end
    end
  end

  def match_transfer_type?(transfer_type = nil)
    # set match if transfer_type is valid
    match = transfer_type && TransferType[transfer_type.to_sym]
    logger.debug "#{match.inspect}"
    # if not match any transfer type it needs to concern ? return false
    # else look over each transfer items of each transfering_asset to
    # find out if the transfer items are match transfer_type
    return !!match && transfering_assets.any? do |tr|
      trans_fms = tr.asset_transfer_item_froms.collect(&match[:match]).reject(&:nil?) 
      trans_tos = tr.asset_transfer_item_tos.collect(&match[:match]).reject(&:nil?) 
      logger.debug "trans_fms:#{trans_fms.inspect}"
      logger.debug "trans_tos:#{trans_tos.inspect}"
      !(trans_fms ^ trans_tos).empty?
    end
  end

  def submit!(user)
    errors.add(:submitted, I18n.t("activerecord.attributes.asset_transfer.transactions.already_submitted", :at => submitted_at, :by => submitted_by)) && return if submitted?
    self.transaction do
      update_attributes(:submitted => true, :submitted_by_id => user.id, :submitted_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def confirm!(user)
    errors.add(:confirmed, I18n.t("activerecord.attributes.asset_transfer.transactions.already_confirmed", :at => confirmed_at, :by => confirmed_by)) && return if confirmed?
    self.transaction do
      update_attributes(:confirmed => true, :confirmed_by_id => user.id, :confirmed_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  def approve!(user)
    errors.add(:approved, I18n.t("activerecord.attributes.asset_transfer.transactions.already_approved", :at => approved_at, :by => approved_by)) && return if approved?
    self.transaction do
      asset_transfer_item_tos.each do |item|
        alloc = AssetAllocation.new_by_asset_transfer_item_to(item, {:created_by_id => user.id, :updated_by_id => user.id})
        alloc.save
        item.update_attributes({:asset_allocation_id => alloc.id, :updated_by_id => user.id, :updated_at => DateTime.now})
      end

      asset_transfer_item_froms.collect(&:asset_allocation).each{|alloc| alloc.disabled_by(user) if alloc }
      update_attributes(:approved => true, :approved_by_id => user.id, :approved_at => DateTime.now, :updated_by_id => user.id)
    end
  end

  private
  def validate_item_tos_total_quantity_euqals_to_one
    current_quantity = asset_transfer_item_tos.map(&:quantity).inject(0,&:+)
    errors.add(:base, I18n.t('activerecord.errors.models.asset_transfer.item_tos_total_quantity_euqals_to_one', current_quantity: current_quantity)) unless current_quantity == 1
  end


end
