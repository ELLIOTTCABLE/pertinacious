require File.dirname(__FILE__) + '/spec_helper'
require 'pertinacious/core_ext/hash'
require 'pertinacious/core_ext/blank'

describe Hash do
  it "should be able to stringify it's keys" do
    {:a => 1, :b => 2}.stringify_keys.should == {'a' => 1, 'b' => 2}
  end
  
  it "should be able to return all but a few specific keys" do
    {:a => 1, :b => 2, :c => 3}.except(:b).should == {:a => 1, :c => 3}
  end
  
  it "should be able to preform a reverse merge" do
    one = {:a => 1, :b => 2, :c => 3}
    two = {:b =>'b',:c =>'c',:d =>'d'}
    merged          = one.merge two
    reverse_merged  = two.reverse_merge! one
    reverse_merged.should == merged
  end
  
  describe "#compact!" do
    it "should compact itself" do
      {:a => 1, :b => nil, :c => ""}.compact.should == {:a => 1, :c => ""}
    end
    
    it "should compact itself in place" do
      hash = {:a => 1, :b => nil, :c => ""}
      hash.compact!
      hash.should == {:a => 1, :c => ""}
    end
    
    it "should take a method to test for compactibility" do
      pending
    end
    
    it "should take a method to test for compactibility and compact in place" do
      hash = {:a => 1, :b => nil, :c => ""}
      hash.compact! :blank?
      hash.should == {:a => 1}
    end
  end
  
end