class AssetCostAdjustmentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  before_filter :load_asset_cost_adjustment, only: [:show, :edit, :update, :destroy]

  # GET /asset_cost_adjustments
  # GET /asset_cost_adjustments.json
  # GET /asset_cost_adjustments.xml
  def index
    @asset_cost_adjustments = AssetCostAdjustment.accessible_by(current_ability).search(params[:search]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asset_cost_adjustments }
      format.xml  { render xml: @asset_cost_adjustments }
    end
  end

  # GET /asset_cost_adjustments/1
  # GET /asset_cost_adjustments/1.json
  # GET /asset_cost_adjustments/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset_cost_adjustment }
      format.xml  { render xml: @asset_cost_adjustment }
    end
  end

  # GET /asset_cost_adjustments/new
  # GET /asset_cost_adjustments/new.json
  # GET /asset_cost_adjustments/new.xml
  def new
    @asset_cost_adjustment = AssetCostAdjustment.new_with_asset(Asset.where(:id => params[:asset_id]).first)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset_cost_adjustment }
      format.xml  { render xml: @asset_cost_adjustment }
    end
  end

  # GET /asset_cost_adjustments/1/edit
  def edit
  end

  # POST /asset_cost_adjustments
  # POST /asset_cost_adjustments.json
  # POST /asset_cost_adjustments.xml
  def create
    @asset_cost_adjustment = AssetCostAdjustment.new(params[:asset_cost_adjustment])

    respond_to do |format|
      if @asset_cost_adjustment.save
        format.html { redirect_to @asset_cost_adjustment, notice: I18n.t('controllers.create_success', name: @asset_cost_adjustment.class.model_name.human) }
        format.json { render json: @asset_cost_adjustment, status: :created, location: @asset_cost_adjustment }
        format.xml  { render xml: @asset_cost_adjustment, status: :created, location: @asset_cost_adjustment }
      else
        format.html { render action: "new" }
        format.json { render json: @asset_cost_adjustment.errors, status: :unprocessable_entity }
        format.xml  { render xml: @asset_cost_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /asset_cost_adjustments/1
  # PUT /asset_cost_adjustments/1.json
  # PUT /asset_cost_adjustments/1.xml
  def update
    respond_to do |format|
      if @asset_cost_adjustment.update_attributes(params[:asset_cost_adjustment])
        format.html { redirect_to @asset_cost_adjustment, notice: I18n.t('controllers.update_success', name: @asset_cost_adjustment.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset_cost_adjustment.errors, status: :unprocessable_entity }
        format.xml  { render xml: @asset_cost_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_cost_adjustments/1
  # DELETE /asset_cost_adjustments/1.json
  # DELETE /asset_cost_adjustments/1.xml
  def destroy
    #@asset_cost_adjustment = AssetCostAdjustment.find(params[:id])
    if @asset_cost_adjustment.destroy && @asset_cost_adjustment.destroy
      respond_to do |format|
        format.html { redirect_to asset_cost_adjustments_url, notice: I18n.t('controllers.destroy_success', name: @asset_cost_adjustment.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_cost_adjustments_url, notice: I18n.t('controllers.destroy_fail', name: @asset_cost_adjustment.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  private
  # Use callback to share common setup or constraints between actions
  def load_asset_cost_adjustment
    @asset_cost_adjustment = AssetCostAdjustment.accessible_by(current_ability).find(params[:id])
  end
  
  # User this method to whitelist the permissible parameters. Example:
  #   params.require(:person).permit(:name, :age)
  #
  # Also, you can specialize this method with per-user checking of permissible
  # attributes.
  def asset_cost_adjustment_params
    params.require(:asset_cost_adjustment).permit()
  end
end
