class AssetTransfer < ActiveRecord::Base
  attr_accessible :approved_at, :approved_by_id, :confirmed_at, :confirmed_by_id, :created_by_id, :document_status, :effective_date, :published, :published_at, :rejected_at, :rejected_by_id, :submitted_at, :submitted_by_id, :updated_by_id, :transfering_assets_attributes, :transfer_type

  has_many :transfering_assets, :class_name => "TransferingAsset", :foreign_key => "refer_id_from"
  accepts_nested_attributes_for :transfering_assets
  has_many :asset_transfer_item_froms, :class_name => "AssetTransferItemFrom", :through => :transfering_assets
  has_many :asset_transfer_item_tos, :class_name => "AssetTransferItemTo", :through => :transfering_assets

  TransferType = {:responsible_transfer => (1 << 0), 
                  :management_department_transfer => (1 << 1), 
                  :cost_center_transfer => (1 << 2)}

  scope :search, lambda{|search|
  }

  def self.description_for_transfer_type(type)
    type = TransferType.collect{ |t| t.include?(type) && t }.first || TransferType.first
    I18n.t("activerecord.attributes.asset_transfer.transfer_types.#{type.first.to_s}")
  end

  def self.description_for_transfer_types
    TransferType.collect{|t| I18n.t("activerecord.attributes.asset_transfer.transfer_types.#{t.first.to_s}")}
  end

  def self.new_with_asset(target = nil, user_id = nil)
    instance = new(:created_by_id => user_id, :updated_by_id => user_id)
    if target && target.is_a?(Asset)
      instance.transfering_assets << TransferingAsset.new(:asset_id => target.id, :created_by_id => user_id, :updated_by_id => user_id)
      instance.transfering_assets.each do |tr|
        tr.asset_transfer_item_froms << tr.asset.allocations.collect do |alloc|
          AssetTransferItemFrom.new(:created_by_id => user_id, :updated_by_id => user_id) do |trans_fm|
            allocation_attributes.each{|attr| trans_fm.__send__("#{attr.to_s}=", alloc.__send__("#{attr.to_s}"))}
          end
        end 
        if tr.asset_transfer_item_froms.empty?
          tr.asset_transfer_item_tos << AssetTransferItemTo.new(:created_by_id => user_id, :updated_by_id => user_id, :quantity => 1)
        else
          tr.asset_transfer_item_tos << tr.asset_transfer_item_froms.collect do |trans_fm|
            AssetTransferItemTo.new(:created_by_id => user_id, :updated_by_id => user_id) do |trans_to|
              allocation_attributes.each{|attr| trans_to.__send__("#{attr.to_s}=", trans_fm.__send__("#{attr.to_s}"))}
            end
          end
        end
      end 
    end
    return instance
  end

  def transfer_type_description_list
    transfer_type_list.collect{|t| self.class.description_for_transfer_type(t)}
  end

  def transfer_type_list
    Array(transfer_type.to_s(2).reverse.chars).collect(&:to_i).select{|i| TransferType.values.include?(i)}.uniq
  end

  before_save :update_trasfer_type
  def update_trasfer_type
    self.transfer_type = TransferType.keys.inject(0) do |acc, trans_type| 
      acc |= match_transfer_type?(trans_type) ? TransferType[trans_type] : 0
    end
  end

  def match_transfer_type?(transfer_type = nil)
    return false unless transfer_type
    match = TransferType.keys.zip([:responsible_by, :management_department_id, :cost_center_id]).select{ |c| c.first == transfer_type.to_sym }.first
    return !!match && transfering_assets.any? do |tr|
      trans_fms = tr.asset_transfer_item_froms.collect(&match.last).reject(&:nil?) 
      trans_tos = tr.asset_transfer_item_tos.collect(&match.last).reject(&:nil?) 
      logger.debug "trans_fms:#{trans_fms.inspect}"
      logger.debug "trans_tos:#{trans_tos.inspect}"
      !((trans_fms | trans_tos) - (trans_fms & trans_tos)).empty?
    end
  end

end
