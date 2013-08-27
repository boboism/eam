class AssetInfoAdjustmentsController < ApplicationController
  #before_filter :authenticate_user!
  #load_and_authorize_resource
  
  before_filter :load_asset_info_adjustment, only: [:show, :edit, :update, :destroy]

  # GET /asset_info_adjustments
  # GET /asset_info_adjustments.json
  # GET /asset_info_adjustments.xml
  def index
    @asset_info_adjustments = AssetInfoAdjustment.accessible_by(current_ability).search(params[:search]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asset_info_adjustments }
      format.xml  { render xml: @asset_info_adjustments }
    end
  end

  # GET /asset_info_adjustments/confirmable
  # GET /asset_info_adjustments/confirmable.json
  # GET /asset_info_adjustments/confirmable.xml
  def index_confirmable
    @asset_info_adjustments = AssetInfoAdjustment.accessible_by(current_ability, :confirm).search(params[:search]).page(params[:page])

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @asset_info_adjustments }
      format.xml  { render xml: @asset_info_adjustments }
    end
  end

  # GET /asset_info_adjustments/approvable
  # GET /asset_info_adjustments/approvable.json
  # GET /asset_info_adjustments/approvable.xml
  def index_approvable
    @asset_info_adjustments = AssetInfoAdjustment.accessible_by(current_ability, :approve).search(params[:search]).page(params[:page])

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @asset_info_adjustments }
      format.xml  { render xml: @asset_info_adjustments }
    end
  end

  # GET /asset_info_adjustments/1
  # GET /asset_info_adjustments/1.json
  # GET /asset_info_adjustments/1.xml
  def show
    respond_to do |format|
      if @asset_info_adjustment
        format.html # show.html.erb
        format.json { render json: @asset_info_adjustment }
        format.xml  { render xml: @asset_info_adjustment }
      else
        format.html { redirect_to asset_info_adjustments_url, flash: { error: I18n.t('controllers.find_fail', name: AssetInfoAdjustment.model_name.human) } }
      end
    end
  end

  # GET /asset_info_adjustments/new
  # GET /asset_info_adjustments/new.json
  # GET /asset_info_adjustments/new.xml
  def new
    @asset_info_adjustment = AssetInfoAdjustment.new_with_asset(Asset.find(params[:asset_id]), default_attributes)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset_info_adjustment }
      format.xml  { render xml: @asset_info_adjustment }
    end
  end

  # GET /asset_info_adjustments/1/edit
  def edit
  end

  # POST /asset_info_adjustments
  # POST /asset_info_adjustments.json
  # POST /asset_info_adjustments.xml
  def create
    @asset_info_adjustment = AssetInfoAdjustment.new(default_attributes.merge(params[:asset_info_adjustment]))

    respond_to do |format|
      if @asset_info_adjustment.save
        format.html { redirect_to @asset_info_adjustment, notice: I18n.t('controllers.create_success', name: @asset_info_adjustment.class.model_name.human) }
        format.json { render json: @asset_info_adjustment, status: :created, location: @asset_info_adjustment }
        format.xml  { render xml: @asset_info_adjustment, status: :created, location: @asset_info_adjustment }
      else
        format.html { render action: "new" }
        format.json { render json: @asset_info_adjustment.errors, status: :unprocessable_entity }
        format.xml  { render xml: @asset_info_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /asset_info_adjustments/1
  # PUT /asset_info_adjustments/1.json
  # PUT /asset_info_adjustments/1.xml
  def update
    respond_to do |format|
      if @asset_info_adjustment.update_attributes(params[:asset_info_adjustment])
        format.html { redirect_to @asset_info_adjustment, notice: I18n.t('controllers.update_success', name: @asset_info_adjustment.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset_info_adjustment.errors, status: :unprocessable_entity }
        format.xml  { render xml: @asset_info_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_info_adjustments/1
  # DELETE /asset_info_adjustments/1.json
  # DELETE /asset_info_adjustments/1.xml
  def destroy
    #@asset_info_adjustment = AssetInfoAdjustment.find(params[:id])
    if @asset_info_adjustment.destroy && @asset_info_adjustment.destroy
      respond_to do |format|
        format.html { redirect_to asset_info_adjustments_url, notice: I18n.t('controllers.destroy_success', name: @asset_info_adjustment.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_info_adjustments_url, notice: I18n.t('controllers.destroy_fail', name: @asset_info_adjustment.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /asset_info_adjustments/1/submit
  # PUT /asset_info_adjustments/1/submit.json
  # PUT /asset_info_adjustments/1/submit.xml
  def submit
    @asset_info_adjustment = AssetInfoAdjustment.accessible_by(current_ability, :submit).find(params[:id])
    if @asset_info_adjustment.submit!(current_user)
      respond_to do |format|
        format.html { redirect_to asset_info_adjustments_url, notice: I18n.t('controllers.submit_success', name: @asset_info_adjustment.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_info_adjustments_url, flash: {error: @asset_info_adjustment.errors} }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /asset_info_adjustments/1/confirm
  # PUT /asset_info_adjustments/1/confirm.json
  # PUT /asset_info_adjustments/1/confirm.xml
  def confirm
    @asset_info_adjustment = AssetInfoAdjustment.accessible_by(current_ability, :confirm).find(params[:id])
    if @asset_info_adjustment.confirm!(current_user)
      respond_to do |format|
        format.html { redirect_to asset_info_adjustments_url, notice: I18n.t('controllers.confirm_success', name: @asset_info_adjustment.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_info_adjustments_url, flash: {error: @asset_info_adjustment.errors} }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /asset_info_adjustments/1/approve
  # PUT /asset_info_adjustments/1/approve.json
  # PUT /asset_info_adjustments/1/approve.xml
  def approve
    @asset_info_adjustment = AssetInfoAdjustment.accessible_by(current_ability, :approve).find(params[:id])
    if @asset_info_adjustment.approve!(current_user)
      respond_to do |format|
        format.html { redirect_to asset_info_adjustments_url, notice: I18n.t('controllers.approve_success', name: @asset_info_adjustment.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_info_adjustments_url, flash: {error: @asset_info_adjustment.errors} }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  private
  # Use callback to share common setup or constraints between actions
  def load_asset_info_adjustment
    @asset_info_adjustment = AssetInfoAdjustment.accessible_by(current_ability).where(id: params[:id]).limit(1).first
  end
  
  # User this method to whitelist the permissible parameters. Example:
  #   params.require(:person).permit(:name, :age)
  #
  # Also, you can specialize this method with per-user checking of permissible
  # attributes.
  def asset_info_adjustment_params
    params.require(:asset_info_adjustment).permit()
  end

  def default_attributes
    defaults = {effective_date: Date.current, 
                is_tariff_free_to: false,
                is_specific_fund_to: false,
                tax_preference_id_to: TaxPreference.first.id,
                is_vat_free_to: true,
                vat_to: 0,
                vat_rate_to: 0,
                submitted: false,
                confirmed: false,
                approved: false,
                created_by_id: current_user.id,
                updated_by_id: current_user.id
    }
  end
end
