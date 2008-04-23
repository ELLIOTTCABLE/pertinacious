require File.dirname(__FILE__) + '/spec_helper'
require 'pertinacious/core_ext/object'
require 'pertinacious/core_ext/blank'

class BlankSpecHelper
  def empty?
    true
  end
end

describe Object do
  it "should not be blank" do
    Object.new.should_not be_blank
  end
  
  describe "(of an arbitrary class)" do
    it "should check #empty? for blank-ness" do
      BlankSpecHelper.new.should be_blank
    end
  end
end

describe TrueClass do
  it "should not be blank" do
    true.should_not be_blank
  end
end

describe FalseClass do
  it "should always be blank" do
    false.should be_blank
  end
end

describe Array do
  it "should be blank if it is empty" do
    [].should be_blank
  end
  
  it "should not be blank if it is not empty" do
    [1, 2, 3].should_not be_blank
  end
  
  it "should be blank if it contains only nils" do
    [nil, nil, nil].should be_blank
  end
end

describe Hash do
  it "should be blank if it is empty" do
    {}.should be_blank
  end
  
  it "should not be blank if it is not empty" do
    {:a => 1, :b => 2}.should_not be_blank
  end
  
  it "should be blank if it contains only nils" do
    {nil => nil, nil => nil}.should be_blank
  end
end

describe NilClass do
  it "should be blank" do
    nil.should be_blank
  end
end

describe Numeric do
  it "should not be blank" do
    1.should_not be_blank
    0.should_not be_blank
    
  end
end

describe String do
  it "should be blank if it is empty" do
    "".should be_blank
  end
  
  it "should not be blank if it is not empty" do
    "foo".should_not be_blank
  end
  
  it "should be blank if it is composed entirely of whitespace" do
    "\t\t \n".should be_blank
  end
end