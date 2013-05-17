require 'spec_helper'

describe Department do

  before(:each) do
    @attr = {
      :code => "s01",
      :name => "SC01",
      :enabled => true,
      :description => "DESC"
    }
  end

  it "should create successful" do
    Department.create(:name => "SC01", :code => "s01", :enabled => true).should be_true
  end

  it "should require a code" do
    no_code_dept = Department.new(@attr.merge(:code => ""))
    no_code_dept.should_not be_valid
  end

  it "should require a name" do
    no_name_dept = Department.new(@attr.merge(:name => ""))
    no_name_dept.should_not be_valid
  end
  
  it "should require enabled" do
    no_enabled_dept = Department.new(@attr.merge(:enabled => nil))
    no_enabled_dept.should_not be_valid
  end

  it "should only has uniqe code" do
    Department.create(@attr)
    dept = Department.new(@attr)
    dept.should_not be_valid
  end

end
