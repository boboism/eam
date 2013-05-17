require 'spec_helper'

describe TaxPreference do

  before(:each) do
    @attr = {
      :code => "t01",
      :name => "TP01",
      :enabled => true,
      :description => "DESC"
    }
  end

  it "should create successful" do
    TaxPreference.create(:name => "SC01", :code => "s01", :enabled => true).should be_true
  end

  it "should require a code" do
    no_code_tp = TaxPreference.new(@attr.merge(:code => ""))
    no_code_tp.should_not be_valid
  end

  it "should require a name" do
    no_name_tp = TaxPreference.new(@attr.merge(:name => ""))
    no_name_tp.should_not be_valid
  end
  
  it "should require enabled" do
    no_enabled_tp = TaxPreference.new(@attr.merge(:enabled => nil))
    no_enabled_tp.should_not be_valid
  end

  it "should only has uniqe code" do
    TaxPreference.create(@attr)
    tp = TaxPreference.new(@attr)
    tp.should_not be_valid
  end

end
