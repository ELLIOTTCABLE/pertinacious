require File.dirname(__FILE__) + '/spec_helper'
require 'pertinacious/core_ext/string'

describe String do
  
  describe '#/' do
    it 'should concatenate strings' do
      'lib' / 'core_ext'.should == 'lib/core_ext'
      'lib/core_ext' / 'foo'.should == 'lib/core_ext/foo'
    end
    
    it 'should concatenate symbols' do
      'lib' / :core_ext.should == 'lib/core_ext'
      'lib/core_ext' / :foo.should == 'lib/core_ext/foo'
    end
  end
  
  it "should be able to tell if it ends with another string" do
    'abc'.ends_with?('bc').should be_true
  end
  
  it "should be able to convert itself between CamelCase and snake_case" do
    'MyCoolThing'.snake_case.should == 'my_cool_thing'
    'my_cool_thing'.camel_case.should == 'MyCoolThing'
  end
  
  it "should be able to demodulize itself" do
    'Foo::Bar::Gaz'.demodulize.should == 'Gaz'
  end
  
  describe '#constantize' do
    it "should return a constant based on a string" do
      Abc = :bar
      "::Abc".constantize.should == :bar
    end
    
    it "should reject malformed constant names" do
      lambda { "This can't be a constant name!".constantize }.should raise_error(NameError, /"This can't be a constant name!" is not a valid constant name!/)
    end
  end
  
  # Weirdest indented spec... ever.
  it "should be able to unindent itself" do
    "    this is
      indented
    by four spaces!".chomp.unindent.should == "this is
  indented
by four spaces!".chomp
  end
  
  it "should be able to count its own lines" do
    "a\nb\nc".lines.should == 3
  end
  
end