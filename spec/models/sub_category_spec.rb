require 'spec_helper'

describe SubCategory do

  before(:each) do
    @attr = {
      :code => "s01",
      :name => "SC01",
      :enabled => true,
      :description => "DESC"
    }
  end

  it "should create successful" do
    SubCategory.create(:name => "SC01", :code => "s01", :enabled => true).should be_true
  end

  it "should require a code" do
    no_code_sub_cat = SubCategory.new(@attr.merge(:code => ""))
    no_code_sub_cat.should_not be_valid
  end

  it "should require a name" do
    no_name_sub_cat = SubCategory.new(@attr.merge(:name => ""))
    no_name_sub_cat.should_not be_valid
  end
  
  it "should require enabled" do
    no_enabled_sub_cat = SubCategory.new(@attr.merge(:enabled => nil))
    no_enabled_sub_cat.should_not be_valid
  end

  it "should only has uniqe code" do
    SubCategory.create(@attr)
    sub_cat = SubCategory.new(@attr)
    sub_cat.should_not be_valid
  end

end
