require 'spec_helper'

describe Asset do
  before(:each) do
    @attr = {
    
    }
  end

  it "should require a valid asset_name before accepted" do
    asset = FactoryGirl.new(:asset) do |a|
      a.accepted = false
      a.asset_name = ""
    end

    asset.should_not be_valid
  end
end
