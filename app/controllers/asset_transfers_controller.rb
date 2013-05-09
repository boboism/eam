class AssetTransfersController < ApplicationController
  #before_filter :authenticate_user!
  #load_and_authorize_resource
  
  before_filter :load_asset_transfer, only: [:show, :edit, :update, :destroy]

  # GET /asset_transfers
  # GET /asset_transfers.json
  # GET /asset_transfers.xml
  def index
    @asset_transfers = AssetTransfer.accessible_by(current_ability).search(params[:search]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
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
    @asset_transfer = AssetTransfer.new_with_asset(Asset.where(:id => params[:asset_id]).first)
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
    @asset_transfer = AssetTransfer.new(params[:asset_transfer])

    respond_to do |format|
      if @asset_transfer.save
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
    if @asset_transfer.destroy && @asset_transfer.destroy
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
