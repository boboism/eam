require 'spec_helper'

describe SpecificInvestment do

  before(:each) do
    @attr = {
      :code => "s01",
      :name => "SC01",
      :enabled => true,
      :description => "DESC"
    }
  end

  it "should create successful" do
    SpecificInvestment.create(:name => "SC01", :code => "s01", :enabled => true).should be_true
  end

  it "should require a code" do
    no_code_si = SpecificInvestment.new(@attr.merge(:code => ""))
    no_code_si.should_not be_valid
  end

  it "should require a name" do
    no_name_si = SpecificInvestment.new(@attr.merge(:name => ""))
    no_name_si.should_not be_valid
  end
  
  it "should require enabled" do
    no_enabled_si = SpecificInvestment.new(@attr.merge(:enabled => nil))
    no_enabled_si.should_not be_valid
  end

  it "should only has uniqe code" do
    SpecificInvestment.create(@attr)
    si = SpecificInvestment.new(@attr)
    si.should_not be_valid
  end

end
