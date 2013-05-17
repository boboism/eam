require 'spec_helper'

describe Category do

  before(:each) do
    @attr = {
      :code => "s01",
      :name => "SC01",
      :enabled => true,
      :description => "DESC"
    }
  end

  it "should create successful" do
    Category.create(:name => "SC01", :code => "s01", :enabled => true).should be_true
  end

  it "should require a code" do
    no_code_cat = Category.new(@attr.merge(:code => ""))
    no_code_cat.should_not be_valid
  end

  it "should require a name" do
    no_name_cat = Category.new(@attr.merge(:name => ""))
    no_name_cat.should_not be_valid
  end
  
  it "should require enabled" do
    no_enabled_cat = Category.new(@attr.merge(:enabled => nil))
    no_enabled_cat.should_not be_valid
  end

  it "should only has uniqe code" do
    Category.create(@attr)
    cat = Category.new(@attr)
    cat.should_not be_valid
  end

end
