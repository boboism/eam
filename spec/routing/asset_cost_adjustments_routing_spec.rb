require "spec_helper"

describe AssetCostAdjustmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/asset_cost_adjustments").should route_to("asset_cost_adjustments#index")
    end

    it "routes to #new" do
      get("/asset_cost_adjustments/new").should route_to("asset_cost_adjustments#new")
    end

    it "routes to #show" do
      get("/asset_cost_adjustments/1").should route_to("asset_cost_adjustments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/asset_cost_adjustments/1/edit").should route_to("asset_cost_adjustments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/asset_cost_adjustments").should route_to("asset_cost_adjustments#create")
    end

    it "routes to #update" do
      put("/asset_cost_adjustments/1").should route_to("asset_cost_adjustments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/asset_cost_adjustments/1").should route_to("asset_cost_adjustments#destroy", :id => "1")
    end

  end
end
