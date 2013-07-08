class AssetsController < ApplicationController
  #before_filter :authenticate_user!
  #load_and_authorize_resource
  
  before_filter :load_asset, only: [:show, :edit, :update, :destroy]

  # GET /assets
  # GET /assets.json
  # GET /assets.xml
  def index
    @assets = Asset.accessible_by(current_ability).search(params[:search]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assets }
      format.xml  { render xml: @assets }
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  # GET /assets/1.xml
  def show
    @asset_info_adjustments = AssetInfoAdjustment.where(:asset_id => params[:id])
    @asset_cost_adjustments = AssetCostAdjustment.where(:asset_id => params[:id])
    @asset_transfers        = @asset.asset_transfers
    @asset_categorization_item   = @asset.asset_categorization_item
    @accessory_adjusting_assets = @asset.accessory_adjusting_assets
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset }
      format.xml  { render xml: @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.json
  # GET /assets/new.xml
  def new
    @asset = Asset.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset }
      format.xml  { render xml: @asset }
    end
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  # POST /assets.xml
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: I18n.t('controllers.create_success', name: @asset.class.model_name.human) }
        format.json { render json: @asset, status: :created, location: @asset }
        format.xml  { render xml: @asset, status: :created, location: @asset }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
        format.xml  { render xml: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.json
  # PUT /assets/1.xml
  def update
    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to @asset, notice: I18n.t('controllers.update_success', name: @asset.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
        format.xml  { render xml: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  # DELETE /assets/1.xml
  def destroy
    #@asset = Asset.find(params[:id])
    if @asset.destroy && @asset.destroy
      respond_to do |format|
        format.html { redirect_to assets_url, notice: I18n.t('controllers.destroy_success', name: @asset.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to assets_url, notice: I18n.t('controllers.destroy_fail', name: @asset.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  private
  # Use callback to share common setup or constraints between actions
  def load_asset
    @asset = Asset.accessible_by(current_ability).find(params[:id])
  end
  
  # User this method to whitelist the permissible parameters. Example:
  #   params.require(:person).permit(:name, :age)
  #
  # Also, you can specialize this method with per-user checking of permissible
  # attributes.
  def asset_params
    params.require(:asset).permit()
  end
end
