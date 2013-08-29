class AccessoryAdjustmentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :load_accessory_adjustment, only: [:show, :edit, :update, :destroy]

  # GET /accessory_adjustments
  # GET /accessory_adjustments.json
  # GET /accessory_adjustments.xml
  def index
    @accessory_adjustments = AccessoryAdjustment.accessible_by(current_ability).search(params[:search]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accessory_adjustments }
      format.xml  { render xml: @accessory_adjustments }
    end
  end

  # GET /accessory_adjustments
  # GET /accessory_adjustments.json
  # GET /accessory_adjustments.xml
  def index_confirmable
    @accessory_adjustments = AccessoryAdjustment.accessible_by(current_ability, :confirm).search(params[:search]).page(params[:page])

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @accessory_adjustments }
      format.xml  { render xml: @accessory_adjustments }
    end
  end

  # GET /accessory_adjustments
  # GET /accessory_adjustments.json
  # GET /accessory_adjustments.xml
  def index_approvable
    @accessory_adjustments = AccessoryAdjustment.accessible_by(current_ability, :approve).search(params[:search]).page(params[:page])

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @accessory_adjustments }
      format.xml  { render xml: @accessory_adjustments }
    end
  end

  # GET /accessory_adjustments/1
  # GET /accessory_adjustments/1.json
  # GET /accessory_adjustments/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @accessory_adjustment }
      format.xml  { render xml: @accessory_adjustment }
    end
  end

  # GET /accessory_adjustments/new
  # GET /accessory_adjustments/new.json
  # GET /accessory_adjustments/new.xml
  def new
    @accessory_adjustment = AccessoryAdjustment.new_by_asset_and_user(Asset.where(:id => params[:asset_id]).first, current_user)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accessory_adjustment }
      format.xml  { render xml: @accessory_adjustment }
    end
  end

  # GET /accessory_adjustments/1/edit
  def edit
  end

  # POST /accessory_adjustments
  # POST /accessory_adjustments.json
  # POST /accessory_adjustments.xml
  def create
    @accessory_adjustment = current_user.accessory_adjustments.build(params[:accessory_adjustment])

    respond_to do |format|
      if @accessory_adjustment.save
        format.html { redirect_to @accessory_adjustment, notice: I18n.t('controllers.create_success', name: @accessory_adjustment.class.model_name.human) }
        format.json { render json: @accessory_adjustment, status: :created, location: @accessory_adjustment }
        format.xml  { render xml: @accessory_adjustment, status: :created, location: @accessory_adjustment }
      else
        format.html { render action: "new" }
        format.json { render json: @accessory_adjustment.errors, status: :unprocessable_entity }
        format.xml  { render xml: @accessory_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accessory_adjustments/1
  # PUT /accessory_adjustments/1.json
  # PUT /accessory_adjustments/1.xml
  def update
    respond_to do |format|
      if @accessory_adjustment.update_attributes(params[:accessory_adjustment])
        format.html { redirect_to @accessory_adjustment, notice: I18n.t('controllers.update_success', name: @accessory_adjustment.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @accessory_adjustment.errors, status: :unprocessable_entity }
        format.xml  { render xml: @accessory_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accessory_adjustments/1
  # DELETE /accessory_adjustments/1.json
  # DELETE /accessory_adjustments/1.xml
  def destroy
    #@accessory_adjustment = AccessoryAdjustment.find(params[:id])
    if @accessory_adjustment.destroy
      respond_to do |format|
        format.html { redirect_to accessory_adjustments_url, notice: I18n.t('controllers.destroy_success', name: @accessory_adjustment.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to accessory_adjustments_url, falsh: { error: I18n.t('controllers.destroy_fail', name: @accessory_adjustment.class.model_name.human) } }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /accessory_adjustments/1/submit
  # PUT /accessory_adjustments/1/submit.json
  # PUT /accessory_adjustments/1/submit.xml
  def submit
    #@accessory_adjustment = AccessoryAdjustment.find(params[:id])
    @accessory_adjustment = AccessoryAdjustment.accessible_by(current_ability, :submit).find(params[:id])
    if @accessory_adjustment.submit!(current_user)
      respond_to do |format|
        format.html { redirect_to accessory_adjustments_url, notice: I18n.t('controllers.submit_success', name: @accessory_adjustment.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to accessory_adjustments_url, falsh: { error: I18n.t('controllers.submit_fail', name: @accessory_adjustment.class.model_name.human) } }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /accessory_adjustments/1/confirm
  # PUT /accessory_adjustments/1/confirm.json
  # PUT /accessory_adjustments/1/confirm.xml
  def confirm 
    @accessory_adjustment = AccessoryAdjustment.accessible_by(current_ability, :confirm).find(params[:id])
    if @accessory_adjustment.confirm!(current_user)
      respond_to do |format|
        format.html { redirect_to accessory_adjustments_url, notice: I18n.t('controllers.confirm_success', name: @accessory_adjustment.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to accessory_adjustments_url, falsh: { error: I18n.t('controllers.confirm_fail', name: @accessory_adjustment.class.model_name.human) } }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /accessory_adjustments/1/approve
  # PUT /accessory_adjustments/1/approve.json
  # PUT /accessory_adjustments/1/approve.xml
  def approve 
    @accessory_adjustment = AccessoryAdjustment.accessible_by(current_ability, :approve).find(params[:id])
    if @accessory_adjustment.approve!(current_user)
      respond_to do |format|
        format.html { redirect_to accessory_adjustments_url, notice: I18n.t('controllers.approve_success', name: @accessory_adjustment.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to accessory_adjustments_url, falsh: { error: I18n.t('controllers.approve_fail', name: @accessory_adjustment.class.model_name.human) } }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  private
  # Use callback to share common setup or constraints between actions
  def load_accessory_adjustment
    @accessory_adjustment = AccessoryAdjustment.accessible_by(current_ability).find(params[:id])
  end

  # User this method to whitelist the permissible parameters. Example:
  #   params.require(:person).permit(:name, :age)
  #
  # Also, you can specialize this method with per-user checking of permissible
  # attributes.
  def accessory_adjustment_params
    params.require(:accessory_adjustment).permit()
  end
end
