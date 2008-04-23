require File.dirname(__FILE__) + '/spec_helper'
require 'pertinacious/core_ext/enumerable'

describe Enumerable do
  it "should map with an index" do
    [:a, :b, :c].map_with_index {|_, i|i}.should == [0, 1, 2]
  end
end