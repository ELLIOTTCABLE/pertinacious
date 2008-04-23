require File.dirname(__FILE__) + '/spec_helper'
require 'pertinacious'
require 'pertinacious/core'

describe Pertinacious::Core do
  describe '- descendant', Class do
    before(:each) do
      @klass = Class.new do
        attr_writer :foo
        attr_reader :bar
        attr_accessor :gaz
      end
    end

    it "should persist data created with an attr_writer" do
      pending
      @instance = @klass.new
      @instance.foo = 1
      uuid = @instance.uuid
      @instance = @klass.find_by_uuid(uuid)
      @instance.class_eval do
        @foo.should be(1)
      end
    end

  end
end