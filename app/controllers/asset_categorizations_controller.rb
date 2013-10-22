class AssetCategorizationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :load_asset_categorization, only: [:show, :edit, :update, :destroy, :submit]

  # GET /asset_categorizations
  # GET /asset_categorizations.json
  # GET /asset_categorizations.xml
  def index
    @asset_categorizations = AssetCategorization.accessible_by(current_ability).search(params[:search]).where(created_by_id: current_user.try(:id)).order("approved, confirmed, number_arranged, submitted, id desc").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asset_categorizations }
      format.xml  { render xml: @asset_categorizations }
    end
  end

  # GET /asset_categorizations
  # GET /asset_categorizations.json
  # GET /asset_categorizations.xml
  def index_approvable
    @asset_categorizations = AssetCategorization.accessible_by(current_ability, :approve).search(params[:search]).order("approved, confirmed, number_arranged, submitted, id desc").page(params[:page])

    respond_to do |format|
      format.html 
      format.json { render json: @asset_categorizations }
      format.xml  { render xml: @asset_categorizations }
    end
  end

  # GET /asset_categorizations
  # GET /asset_categorizations.json
  # GET /asset_categorizations.xml
  def index_number_arrangeable
    @asset_categorizations = AssetCategorization.accessible_by(current_ability, :arrange_number).search(params[:search]).order("approved, confirmed, number_arranged, submitted, id desc").page(params[:page])

    respond_to do |format|
      format.html 
      format.json { render json: @asset_categorizations }
      format.xml  { render xml: @asset_categorizations }
    end
  end

  # GET /asset_categorizations
  # GET /asset_categorizations.json
  # GET /asset_categorizations.xml
  def index_confirmable
    @asset_categorizations = AssetCategorization.accessible_by(current_ability, :confirm).search(params[:search]).order("approved, confirmed, number_arranged, submitted, id desc").page(params[:page])

    respond_to do |format|
      format.html 
      format.json { render json: @asset_categorizations }
      format.xml  { render xml: @asset_categorizations }
    end
  end

  # GET /asset_categorizations/1
  # GET /asset_categorizations/1.json
  # GET /asset_categorizations/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset_categorization }
      format.xml  { render xml: @asset_categorization }
    end
  end

  # GET /asset_categorizations/new
  # GET /asset_categorizations/new.json
  # GET /asset_categorizations/new.xml
  def new
    @asset_categorization = AssetCategorization.new(categorize_type: AssetCategorization::CategorizeType.collect{|k,v| v[:weight]}.last) do |cat|
      1.times{cat.asset_categorization_items.new(vat_rate: 17)}
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset_categorization }
      format.xml  { render xml: @asset_categorization }
    end
  end

  # POST /asset_categorizations/import
  # POST /asset_categorizations/import.json
  # POST /asset_categorizations/import.xml
  def import
    respond_to do |format|
      begin
        # process upload file, must be xls/xlsx(better, 'cause xls only can upload 65000 rows)
        @asset_categorization = AssetCategorization.import(params[:file])
        format.html { render action: "new" }
      rescue => e
        format.html { redirect_to upload_asset_categorizations_url, flash: { error: e.message } }                                                        
      end
    end
  end


  # GET /asset_categorizations/upload
  # GET /asset_categorizations/upload.json
  # GET /asset_categorizations/upload.xml
  def upload
    respond_to do |format|
      format.html # upload.html.erb
    end
  end

  # GET /asset_categorizations/1/edit
  def edit
  end

  # POST /asset_categorizations
  # POST /asset_categorizations.json
  # POST /asset_categorizations.xml
  def create
    #@asset_categorization = AssetCategorization.new(params[:asset_categorization].merge(:created_by_id => current_user.id, :updated_by_id => current_user.id))
    @asset_categorization = AssetCategorization.new_by_splitable_quantity(params[:asset_categorization].merge(:created_by_id => current_user.id, :updated_by_id => current_user.id))
    respond_to do |format|
      if @asset_categorization.save && @asset_categorization.submit!(current_user)
        AssetCategorizationMailer.submitted_email(@asset_categorization.id).deliver
        format.html { redirect_to asset_categorization_url(@asset_categorization), notice: I18n.t('controllers.create_success', name: @asset_categorization.class.model_name.human) }
        format.json { render json: @asset_categorization, status: :created, location: @asset_categorization }
        format.xml  { render xml: @asset_categorization, status: :created, location: @asset_categorization }
      else
        format.html { render action: "new" }
        format.json { render json: @asset_categorization.errors, status: :unprocessable_entity }
        format.xml  { render xml: @asset_categorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /asset_categorizations/1
  # PUT /asset_categorizations/1.json
  # PUT /asset_categorizations/1.xml
  def update
    respond_to do |format|
      if @asset_categorization.update_attributes(params[:asset_categorization])
        format.html { redirect_to @asset_categorization, notice: I18n.t('controllers.update_success', name: @asset_categorization.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset_categorization.errors, status: :unprocessable_entity }
        format.xml  { render xml: @asset_categorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_categorizations/1
  # DELETE /asset_categorizations/1.json
  # DELETE /asset_categorizations/1.xml
  def destroy
    #@asset_categorization = AssetCategorization.find(params[:id])
    if @asset_categorization.destroy
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, notice: I18n.t('controllers.destroy_success', name: @asset_categorization.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, notice: I18n.t('controllers.destroy_fail', name: @asset_categorization.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # POST /asset_categorizations/1
  # POST /asset_categorizations/1.json
  # POST /asset_categorizations/1.xml
  def submit
    #@asset_categorization = AssetCategorization.find(params[:id])
    if @asset_categorization.submit!(current_user)
      AssetCategorizationMailer.submitted_email(@asset_categorization.id).deliver
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, notice: I18n.t('controllers.submit_success', name: @asset_categorization.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, flash: { error: @asset_categorization.errors.messages.values.join } }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # POST /asset_categorizations/1
  # POST /asset_categorizations/1.json
  # POST /asset_categorizations/1.xml
  def confirm
    #@asset_categorization = AssetCategorization.find(params[:id])
    if @asset_categorization.confirm!(current_user)
      AssetCategorizationMailer.confirmed_email(@asset_categorization.id).deliver
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, notice: I18n.t('controllers.confirm_success', name: @asset_categorization.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, flash: { error: @asset_categorization.errors.messages.values.join } }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /asset_categorizations/1
  # PUT /asset_categorizations/1.json
  # PUT /asset_categorizations/1.xml
  def arrange_number
    #@asset_categorization = AssetCategorization.find(params[:id])
    if @asset_categorization.arrange_number!(current_user)
      AssetCategorizationMailer.arranged_email(@asset_categorization.id).deliver
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, notice: I18n.t('controllers.confirm_success', name: @asset_categorization.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, flash: { error: @asset_categorization.errors.messages.values.join } }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /asset_categorizations/1
  # PUT /asset_categorizations/1.json
  # PUT /asset_categorizations/1.xml
  def reject
    #@asset_categorization = AssetCategorization.find(params[:id])
    @asset_categorization = AssetCategorization.accessible_by(current_ability, :reject).where(id: params[:id]).first
    if @asset_categorization && @asset_categorization.reject!(current_user)
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, notice: I18n.t('controllers.reject_success', name: @asset_categorization.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, flash: { error: @asset_categorization.errors.messages.values.join } }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /asset_categorizations/1
  # PUT /asset_categorizations/1.json
  # PUT /asset_categorizations/1.xml
  def approve
    #@asset_categorization = AssetCategorization.find(params[:id])
    if @asset_categorization.approve!(current_user)
      AssetCategorizationMailer.approved_email(@asset_categorization.id).deliver
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, notice: I18n.t('controllers.approve_success', name: @asset_categorization.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to asset_categorizations_url, flash: { error: @asset_categorization.errors.messages.values.join } }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  private
  # Use callback to share common setup or constraints between actions
  def load_asset_categorization
    @asset_categorization = AssetCategorization.accessible_by(current_ability).find(params[:id])
  end

  # User this method to whitelist the permissible parameters. Example:
  #   params.require(:person).permit(:name, :age)
  #
  # Also, you can specialize this method with per-user checking of permissible
  # attributes.
  def asset_categorization_params
    params.require(:asset_categorization).permit()
  end
end
