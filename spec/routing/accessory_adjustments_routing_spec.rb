require "spec_helper"

describe AccessoryAdjustmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/accessory_adjustments").should route_to("accessory_adjustments#index")
    end

    it "routes to #new" do
      get("/accessory_adjustments/new").should route_to("accessory_adjustments#new")
    end

    it "routes to #show" do
      get("/accessory_adjustments/1").should route_to("accessory_adjustments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/accessory_adjustments/1/edit").should route_to("accessory_adjustments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/accessory_adjustments").should route_to("accessory_adjustments#create")
    end

    it "routes to #update" do
      put("/accessory_adjustments/1").should route_to("accessory_adjustments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/accessory_adjustments/1").should route_to("accessory_adjustments#destroy", :id => "1")
    end

  end
end
