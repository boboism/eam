require "spec_helper"

describe AssetTransfersController do
  describe "routing" do

    it "routes to #index" do
      get("/asset_transfers").should route_to("asset_transfers#index")
    end

    it "routes to #new" do
      get("/asset_transfers/new").should route_to("asset_transfers#new")
    end

    it "routes to #show" do
      get("/asset_transfers/1").should route_to("asset_transfers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/asset_transfers/1/edit").should route_to("asset_transfers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/asset_transfers").should route_to("asset_transfers#create")
    end

    it "routes to #update" do
      put("/asset_transfers/1").should route_to("asset_transfers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/asset_transfers/1").should route_to("asset_transfers#destroy", :id => "1")
    end

  end
end
