require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AssetTransfersController do

  # This should return the minimal set of attributes required to create a valid
  # AssetTransfer. As you add validations to AssetTransfer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "asset_id" => "1" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AssetTransfersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all asset_transfers as @asset_transfers" do
      asset_transfer = AssetTransfer.create! valid_attributes
      get :index, {}, valid_session
      assigns(:asset_transfers).should eq([asset_transfer])
    end
  end

  describe "GET show" do
    it "assigns the requested asset_transfer as @asset_transfer" do
      asset_transfer = AssetTransfer.create! valid_attributes
      get :show, {:id => asset_transfer.to_param}, valid_session
      assigns(:asset_transfer).should eq(asset_transfer)
    end
  end

  describe "GET new" do
    it "assigns a new asset_transfer as @asset_transfer" do
      get :new, {}, valid_session
      assigns(:asset_transfer).should be_a_new(AssetTransfer)
    end
  end

  describe "GET edit" do
    it "assigns the requested asset_transfer as @asset_transfer" do
      asset_transfer = AssetTransfer.create! valid_attributes
      get :edit, {:id => asset_transfer.to_param}, valid_session
      assigns(:asset_transfer).should eq(asset_transfer)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AssetTransfer" do
        expect {
          post :create, {:asset_transfer => valid_attributes}, valid_session
        }.to change(AssetTransfer, :count).by(1)
      end

      it "assigns a newly created asset_transfer as @asset_transfer" do
        post :create, {:asset_transfer => valid_attributes}, valid_session
        assigns(:asset_transfer).should be_a(AssetTransfer)
        assigns(:asset_transfer).should be_persisted
      end

      it "redirects to the created asset_transfer" do
        post :create, {:asset_transfer => valid_attributes}, valid_session
        response.should redirect_to(AssetTransfer.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved asset_transfer as @asset_transfer" do
        # Trigger the behavior that occurs when invalid params are submitted
        AssetTransfer.any_instance.stub(:save).and_return(false)
        post :create, {:asset_transfer => { "asset_id" => "invalid value" }}, valid_session
        assigns(:asset_transfer).should be_a_new(AssetTransfer)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        AssetTransfer.any_instance.stub(:save).and_return(false)
        post :create, {:asset_transfer => { "asset_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested asset_transfer" do
        asset_transfer = AssetTransfer.create! valid_attributes
        # Assuming there are no other asset_transfers in the database, this
        # specifies that the AssetTransfer created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        AssetTransfer.any_instance.should_receive(:update_attributes).with({ "asset_id" => "1" })
        put :update, {:id => asset_transfer.to_param, :asset_transfer => { "asset_id" => "1" }}, valid_session
      end

      it "assigns the requested asset_transfer as @asset_transfer" do
        asset_transfer = AssetTransfer.create! valid_attributes
        put :update, {:id => asset_transfer.to_param, :asset_transfer => valid_attributes}, valid_session
        assigns(:asset_transfer).should eq(asset_transfer)
      end

      it "redirects to the asset_transfer" do
        asset_transfer = AssetTransfer.create! valid_attributes
        put :update, {:id => asset_transfer.to_param, :asset_transfer => valid_attributes}, valid_session
        response.should redirect_to(asset_transfer)
      end
    end

    describe "with invalid params" do
      it "assigns the asset_transfer as @asset_transfer" do
        asset_transfer = AssetTransfer.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AssetTransfer.any_instance.stub(:save).and_return(false)
        put :update, {:id => asset_transfer.to_param, :asset_transfer => { "asset_id" => "invalid value" }}, valid_session
        assigns(:asset_transfer).should eq(asset_transfer)
      end

      it "re-renders the 'edit' template" do
        asset_transfer = AssetTransfer.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AssetTransfer.any_instance.stub(:save).and_return(false)
        put :update, {:id => asset_transfer.to_param, :asset_transfer => { "asset_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested asset_transfer" do
      asset_transfer = AssetTransfer.create! valid_attributes
      expect {
        delete :destroy, {:id => asset_transfer.to_param}, valid_session
      }.to change(AssetTransfer, :count).by(-1)
    end

    it "redirects to the asset_transfers list" do
      asset_transfer = AssetTransfer.create! valid_attributes
      delete :destroy, {:id => asset_transfer.to_param}, valid_session
      response.should redirect_to(asset_transfers_url)
    end
  end

end