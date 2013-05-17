require "spec_helper"

describe AssetCategorizationsController do
  describe "routing" do

    it "routes to #index" do
      get("/asset_categorizations").should route_to("asset_categorizations#index")
    end

    it "routes to #new" do
      get("/asset_categorizations/new").should route_to("asset_categorizations#new")
    end

    it "routes to #show" do
      get("/asset_categorizations/1").should route_to("asset_categorizations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/asset_categorizations/1/edit").should route_to("asset_categorizations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/asset_categorizations").should route_to("asset_categorizations#create")
    end

    it "routes to #update" do
      put("/asset_categorizations/1").should route_to("asset_categorizations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/asset_categorizations/1").should route_to("asset_categorizations#destroy", :id => "1")
    end

  end
end
