class AssetTransfersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  before_filter :load_asset_transfer, only: [:show, :edit, :update, :destroy]

  # GET /asset_transfers
  # GET /asset_transfers.json
  # GET /asset_transfers.xml
  def index
    @asset_transfers = AssetTransfer.accessible_by(current_ability).search(params[:search]).order("id desc").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asset_transfers }
      format.xml  { render xml: @asset_transfers }
    end
  end

  # GET /asset_transfers/confirmable
  # GET /asset_transfers/confirmable.json
  # GET /asset_transfers/confirmable.xml
  def index_confirmable
    @asset_transfers = AssetTransfer.accessible_by(current_ability, :confirm).search(params[:search]).order("id desc").page(params[:page])

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @asset_transfers }
      format.xml  { render xml: @asset_transfers }
    end
  end

  # GET /asset_transfers/approvable
  # GET /asset_transfers/approvable.json
  # GET /asset_transfers/approvable.xml
  def index_approvable
    @asset_transfers = AssetTransfer.accessible_by(current_ability, :approve).search(params[:search]).order("id desc").page(params[:page])

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @asset_transfers }
      format.xml  { render xml: @asset_transfers }
    end
  end

  # GET /asset_transfers/1
  # GET /asset_transfers/1.json
  # GET /asset_transfers/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset_transfer }
      format.xml  { render xml: @asset_transfer }
    end
  end

  # GET /asset_transfers/new
  # GET /asset_transfers/new.json
  # GET /asset_transfers/new.xml
  def new
    @asset_transfer = AssetTransfer.new_by_asset_and_user(Asset.where(:id => params[:asset_id]).first, current_user)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset_transfer }
      format.xml  { render xml: @asset_transfer }
    end
  end

  # GET /asset_transfers/1/edit
  def edit
  end

  # POST /asset_transfers
  # POST /asset_transfers.json
  # POST /asset_transfers.xml
  def create
    default_attrs = {created_by_id: current_user.id, updated_by_id: current_user.id}
    at_params = default_attrs.merge(params[:asset_transfer])
    @asset_transfer = AssetTransfer.new(at_params)
    @asset_transfer.asset_transfer_item_froms.each{|item| item.created_by_id, item.updated_by_id = default_attrs[:created_by_id], default_attrs[:updated_by_id]}
    @asset_transfer.asset_transfer_item_tos.each{|item| item.created_by_id, item.updated_by_id = default_attrs[:created_by_id], default_attrs[:updated_by_id]}
    

    respond_to do |format|
      if @asset_transfer.save && @asset_transfer.submit!(current_user)
        format.html { redirect_to @asset_transfer, notice: I18n.t('controllers.create_success', name: @asset_transfer.class.model_name.human) }
        format.json { render json: @asset_transfer, status: :created, location: @asset_transfer }
        format.xml  { render xml: @asset_transfer, status: :created, location: @asset_transfer }
      else
        format.html { render action: "new" }
        format.json { render json: @asset_transfer.errors, status: :unprocessable_entity }
        format.xml  { render xml: @asset_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /asset_transfers/1
  # PUT /asset_transfers/1.json
  # PUT /asset_transfers/1.xml
  def update
    respond_to do |format|
      if @asset_transfer.update_attributes(params[:asset_transfer])
        format.html { redirect_to @asset_transfer, notice: I18n.t('controllers.update_success', name: @asset_transfer.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset_transfer.errors, status: :unprocessable_entity }
        format.xml  { render xml: @asset_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_transfers/1
  # DELETE /asset_transfers/1.json
  # DELETE /asset_transfers/1.xml
  def destroy
    #@asset_transfer = AssetTransfer.find(params[:id])
    if @asset_transfer.destroy 
      respond_to do |format|
        format.html { redirect_to asset_transfers_url, notice: I18n.t('controllers.destroy_success', name: @asset_transfer.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_transfers_url, notice: I18n.t('controllers.destroy_fail', name: @asset_transfer.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /asset_transfers/1/submit
  # PUT /asset_transfers/1/submit.json
  # PUT /asset_transfers/1/submit.xml
  def submit
    @asset_transfer = AssetTransfer.accessible_by(current_ability, :submit).find(params[:id])
    if @asset_transfer.submit!(current_user)
      respond_to do |format|
        format.html { redirect_to asset_transfers_url, notice: I18n.t('controllers.submit_success', name: @asset_transfer.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_transfers_url, flash: {error: @asset_transfer.errors} }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /asset_transfers/1/confirm
  # PUT /asset_transfers/1/confirm.json
  # PUT /asset_transfers/1/confirm.xml
  def confirm
    @asset_transfer = AssetTransfer.accessible_by(current_ability, :confirm).find(params[:id])
    if @asset_transfer.confirm!(current_user)
      respond_to do |format|
        format.html { redirect_to asset_transfers_url, notice: I18n.t('controllers.confirm_success', name: @asset_transfer.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_transfers_url, flash: {error: @asset_transfer.errors} }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /asset_transfers/1/approve
  # PUT /asset_transfers/1/approve.json
  # PUT /asset_transfers/1/approve.xml
  def approve
    @asset_transfer = AssetTransfer.accessible_by(current_ability, :approve).find(params[:id])
    if @asset_transfer.approve!(current_user)
      respond_to do |format|
        format.html { redirect_to asset_transfers_url, notice: I18n.t('controllers.approve_success', name: @asset_transfer.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_transfers_url, flash: {error: @asset_transfer.errors} }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  private
  # Use callback to share common setup or constraints between actions
  def load_asset_transfer
    @asset_transfer = AssetTransfer.accessible_by(current_ability).find(params[:id])
  end
  
  # User this method to whitelist the permissible parameters. Example:
  #   params.require(:person).permit(:name, :age)
  #
  # Also, you can specialize this method with per-user checking of permissible
  # attributes.
  def asset_transfer_params
    params.require(:asset_transfer).permit()
  end
end
