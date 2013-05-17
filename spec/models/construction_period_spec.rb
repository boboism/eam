require 'spec_helper'

describe ConstructionPeriod do

  before(:each) do
    @attr = {
      :code => "s01",
      :name => "SC01",
      :enabled => true,
      :description => "DESC"
    }
  end

  it "should create successful" do
    ConstructionPeriod.create(:name => "SC01", :code => "s01", :enabled => true).should be_true
  end

  it "should require a code" do
    no_code_cp = ConstructionPeriod.new(@attr.merge(:code => ""))
    no_code_cp.should_not be_valid
  end

  it "should require a name" do
    no_name_cp = ConstructionPeriod.new(@attr.merge(:name => ""))
    no_name_cp.should_not be_valid
  end
  
  it "should require enabled" do
    no_enabled_cp = ConstructionPeriod.new(@attr.merge(:enabled => nil))
    no_enabled_cp.should_not be_valid
  end

  it "should only has uniqe code" do
    ConstructionPeriod.create(@attr)
    cp = ConstructionPeriod.new(@attr)
    cp.should_not be_valid
  end

end
