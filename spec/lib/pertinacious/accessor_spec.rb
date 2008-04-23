require File.dirname(__FILE__) + '/spec_helper'
require 'pertinacious'
require 'pertinacious/accessor'

# =========
# = Setup =
# =========

describe "attribute reader", :shared => true do
  before(:each) do
    Pertinacious::Accessor.new :sexiness, @klass, :reader => true, :default => :not_very
  end
  
  it "should respond to the reader method" do
    @klass.new.should respond_to('sexiness')
  end
  
  it "should return the value of the relevant instance variable" do
    instance = @klass.new
    instance.instance_variable_set('@sexiness', :very)
    instance.sexiness.should == :very
  end
  
  it "should return the default value if the relevant instance variable isn't set" do
    instance = @klass.new
    instance.sexiness.should == :not_very
  end
end

describe "attribute writer", :shared => true do
  before(:each) do
    Pertinacious::Accessor.new :sexiness, @klass, :writer => true
  end
  
  it "should respond to the writer method" do
    @klass.new.should respond_to('sexiness=')
  end
  
  it "should set the value of the relevant instance variable" do
    instance = @klass.new
    instance.sexiness = :very
    instance.instance_variable_get('@sexiness').should == :very
  end
end

# =========
# = Specs =
# =========

describe Pertinacious::Accessor do
  before(:each) do
    @klass = Class.new
  end
  
  describe 'accessor creator' do
    it_should_behave_like 'attribute reader'
    it_should_behave_like 'attribute writer'
  end
  
  describe 'reader creator' do
    it_should_behave_like 'attribute reader'
    
    it "should not respond to the writer method" do
      @klass.new.should_not respond_to('sexiness=')
    end
  end
  
  describe 'writer creator' do
    it_should_behave_like 'attribute writer'
    
    it "should not respond to the reader method" do
      @klass.new.should_not respond_to('sexiness')
    end
  end
end