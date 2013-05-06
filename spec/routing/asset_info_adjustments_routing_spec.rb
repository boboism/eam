require "spec_helper"

describe AssetInfoAdjustmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/asset_info_adjustments").should route_to("asset_info_adjustments#index")
    end

    it "routes to #new" do
      get("/asset_info_adjustments/new").should route_to("asset_info_adjustments#new")
    end

    it "routes to #show" do
      get("/asset_info_adjustments/1").should route_to("asset_info_adjustments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/asset_info_adjustments/1/edit").should route_to("asset_info_adjustments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/asset_info_adjustments").should route_to("asset_info_adjustments#create")
    end

    it "routes to #update" do
      put("/asset_info_adjustments/1").should route_to("asset_info_adjustments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/asset_info_adjustments/1").should route_to("asset_info_adjustments#destroy", :id => "1")
    end

  end
end
