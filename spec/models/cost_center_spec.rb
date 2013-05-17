require 'spec_helper'

describe CostCenter do

  before(:each) do
    @attr = {
      :code => "s01",
      :name => "SC01",
      :enabled => true,
      :description => "DESC"
    }
  end

  it "should create successful" do
    CostCenter.create(:name => "SC01", :code => "s01", :enabled => true).should be_true
  end

  it "should require a code" do
    no_code_ccenter = CostCenter.new(@attr.merge(:code => ""))
    no_code_ccenter.should_not be_valid
  end

  it "should require a name" do
    no_name_ccenter = CostCenter.new(@attr.merge(:name => ""))
    no_name_ccenter.should_not be_valid
  end
  
  it "should require enabled" do
    no_enabled_ccenter = CostCenter.new(@attr.merge(:enabled => nil))
    no_enabled_ccenter.should_not be_valid
  end

  it "should only has uniqe code" do
    CostCenter.create(@attr)
    ccenter = CostCenter.new(@attr)
    ccenter.should_not be_valid
  end

end
