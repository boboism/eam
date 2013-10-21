class MasterDatasController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  before_filter :load_master_data, only: [:show, :edit, :update, :destroy]

  # GET /master_data
  # GET /master_data.json
  # GET /master_data.xml
  def index
    @master_datas = MasterData.accessible_by(current_ability).search(params[:search]).order("id desc").page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @master_datas }
      format.xml  { render xml: @master_datas }
    end
  end

  # GET /master_data/confirmable
  # GET /master_data/confirmable.json
  # GET /master_data/confirmable.xml
  def index_confirmable
    @master_data = MasterData.accessible_by(current_ability, :confirm).search(params[:search]).order("id desc").page(params[:page])

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @master_data }
      format.xml  { render xml: @master_data }
    end
  end

  # GET /master_data/approvable
  # GET /master_data/approvable.json
  # GET /master_data/approvable.xml
  def index_approvable
    @master_data = MasterData.accessible_by(current_ability, :approve).search(params[:search]).order("id desc").page(params[:page])

    respond_to do |format|
      format.html { render "index" }
      format.json { render json: @master_data }
      format.xml  { render xml: @master_data }
    end
  end

  # GET /master_data/1
  # GET /master_data/1.json
  # GET /master_data/1.xml
  def show
    respond_to do |format|
      format.html { redirect_to edit_master_data_url(@master_data) }
      format.json { render json: @master_data }
      format.xml  { render xml: @master_data }
    end
  end

  # GET /master_data/new
  # GET /master_data/new.json
  # GET /master_data/new.xml
  def new
    @master_data = MasterData.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @master_data }
      format.xml  { render xml: @master_data }
    end
  end

  # GET /master_data/1/edit
  def edit
  end

  # POST /master_data
  # POST /master_data.json
  # POST /master_data.xml
  def create
    default_attrs = {created_by_id: current_user.id, updated_by_id: current_user.id, enabled: true}
    @master_data = MasterData.new(default_attrs.merge!(params[:master_data]))

    respond_to do |format|
      if @master_data.save
        format.html { redirect_to edit_master_data_path(@master_data), notice: I18n.t('controllers.create_success', name: @master_data.class.model_name.human) }
        format.json { render json: @master_data, status: :created, location: @master_data }
        format.xml  { render xml: @master_data, status: :created, location: @master_data }
      else
        format.html { render action: "new" }
        format.json { render json: @master_data.errors, status: :unprocessable_entity }
        format.xml  { render xml: @master_data.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /master_data/1
  # PUT /master_data/1.json
  # PUT /master_data/1.xml
  def update
    respond_to do |format|
      if @master_data.update_attributes(params[:master_data])

        format.html { redirect_to edit_master_data_path(@master_data), notice: I18n.t('controllers.create_success', name: @master_data.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @master_data.errors, status: :unprocessable_entity }
        format.xml  { render xml: @master_data.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_data/1
  # DELETE /master_data/1.json
  # DELETE /master_data/1.xml
  def destroy
    #@master_data = MasterData.find(params[:id])
    if @master_data.destroy 
      respond_to do |format|
        format.html { redirect_to master_data_url, notice: I18n.t('controllers.destroy_success', name: @master_data.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to master_data_url, notice: I18n.t('controllers.destroy_fail', name: @master_data.class.model_name.human) }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /master_data/1/submit
  # PUT /master_data/1/submit.json
  # PUT /master_data/1/submit.xml
  def submit
    @master_data = MasterData.accessible_by(current_ability, :submit).find(params[:id])
    if @master_data.submit!(current_user)
      respond_to do |format|
        format.html { redirect_to master_data_url, notice: I18n.t('controllers.submit_success', name: @master_data.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to master_data_url, flash: {error: @master_data.errors} }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /master_data/1/enable
  # PUT /master_data/1/enable.json
  # PUT /master_data/1/enable.xml
  def enable
    @master_data = MasterData.accessible_by(current_ability, :enable).find(params[:id])
    if @master_data.enable!(current_user)
      respond_to do |format|
        format.html { redirect_to edit_master_data_url(@master_data), notice: I18n.t('controllers.enable_success', name: @master_data.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to edit_master_data_url(@master_data), flash: {error: @master_data.errors} }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  # PUT /master_data/1/approve
  # PUT /master_data/1/approve.json
  # PUT /master_data/1/approve.xml
  def disable
    @master_data = MasterData.accessible_by(current_ability, :disable).find(params[:id])
    if @master_data.disable!(current_user)
      respond_to do |format|
        format.html { redirect_to edit_master_data_url(@master_data), notice: I18n.t('controllers.disable_success', name: @master_data.class.model_name.human) } 
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to edit_master_data_url(@master_data), flash: {error: @master_data.errors} }
        format.json { head :no_content }
        format.xml  { head :no_content }
      end
    end
  end

  private
  # Use callback to share common setup or constraints between actions
  def load_master_data
    @master_data = MasterData.accessible_by(current_ability).find(params[:id])
  end
  
  # User this method to whitelist the permissible parameters. Example:
  #   params.require(:person).permit(:name, :age)
  #
  # Also, you can specialize this method with per-user checking of permissible
  # attributes.
  def master_data_params
    params.require(:master_datas).permit(:code, :name, :description, :parent_id, :type)
  end
end
