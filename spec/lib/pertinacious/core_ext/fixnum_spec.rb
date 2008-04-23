require File.dirname(__FILE__) + '/spec_helper'
require 'pertinacious/core_ext/fixnum'

describe Fixnum do
  it "should test if it is a multiple of something else" do
    4.should be_a_multiple_of(2)
    6.should be_a_multiple_of(2)
    6.should be_a_multiple_of(3)
    6.should_not be_a_multiple_of(4)
    14.should_not be_a_multiple_of(6)
  end
  
  it "should test even-ness" do
    4.should be_even
    5.should_not be_even
    6.should be_even
  end
  
  it "should test odd-ness" do
    4.should_not be_odd
    5.should be_odd
    6.should_not be_odd
  end
end