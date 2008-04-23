require File.dirname(__FILE__) + '/spec_helper'
require 'pertinacious/core_ext/symbol'

describe Symbol do
  
  describe '#/' do
    it 'should concatenate strings' do
      :lib / 'core_ext'.should == 'lib/core_ext'
      :'lib/core_ext' / 'foo'.should == 'lib/core_ext/foo'
    end
    
    it 'should concatenate symbols' do
      :lib / :core_ext.should == 'lib/core_ext'
      :'lib/core_ext' / :foo.should == 'lib/core_ext/foo'
    end
  end
  
end