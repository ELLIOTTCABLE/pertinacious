module Pertinacious
  # This is the basic model for a Pertinacious Attribute; that is, one of
  # these is created when you utilize the +attribute+ method in a pertinacious
  # class.  
  module Attribute
    # Creates a new +attribute+ and accessors for that attribute on on
    # +target+, 
    def self.new attribute, target, opts = {}, &block
      block ||= lambda { nil }
      
      attribute_reader    =  :"#{attribute}"
      attribute_writer    =  :"#{attribute}="
      attribute_predicate =  :"#{attribute}?"
      attribute_ivar      = :"@#{attribute}"
      
      target.class_eval do
        # The reader is actually destructive - if the ivar isn't defined, it
        # will define it. Use the predicate if you want to non-destructively
        # check whether or not an ivar is defined.
        define_method attribute_reader do
          if send :instance_variable_defined?, attribute_ivar
            send :instance_variable_get, attribute_ivar
          else
            send :instance_variable_set, attribute_ivar, block.call
          end
        end
      
        # Simply sets the instance variable value.
        define_method attribute_writer do |value|
          send :instance_variable_set, attribute_ivar, value
        end
      
        # This will return the truthiness of the ivar, or nil if it's not
        # defined yet.
        define_method attribute_predicate do
          if send :instance_variable_defined?, attribute_ivar
            !!send(:instance_variable_get, attribute_ivar)
          else
            nil
          end
        end
      
        # These default accessors can be changed later with the
        # +Pertinacious::Accessor+ methods.
        public attribute_reader
        public attribute_writer
        public attribute_predicate
      end
      
    end
  end

  module Core
    
    # Creates a new attribute on your class, and makes it pertinacious.
    # Available to all pertinacious classes. It takes a series of symbols as
    # names of attributes, as well as an optional block the define the default
    # value of the attributes.
    # 
    # @param [*Symbol] attributes one or more attribute names (as symbols)
    # @param [&Proc] block accepts a block, which is called to generate the default value
    def attribute *attributes, &block
      # def attribute *attributes, opts, &block # Some day, ruby 1.9, some day...
      opts = attributes.pop if attributes.last.is_a?(Hash)
      
      attributes.each do |attribute|
        ::Pertinacious::Attribute.new attribute, self, opts, &block
      end
    end
    
  end
end

# -- --- Specs --- -- #

describe Pertinacious::Attribute do
  describe '#new' do
    before :each do
      @class = Class.new
      Pertinacious::Attribute.new(:color, @class) { 'blue' }
      @instance = @class.new
    end
    
    describe "(attribute reader)" do
      it "should be created" do
        @class.instance_methods.should include('color')
      end
      
      it "should return the value of the attribute" do
        @instance.instance_eval do
          @color = 'muave'
        end
        @instance.color.should == 'muave'
      end
      
      it "should default to the return value of the default block" do
        @instance.color.should == 'blue'
      end
      
      it "should set the value of the attribute to the default attribute when first called" do
        @instance.color.should == 'blue'
        @instance.instance_eval do
          @color.should == 'blue'
        end
      end
    end # (attribute reader)
    
    describe "(attribute writer)" do
      it "should be created" do
        @class.instance_methods.should include('color=')
      end
      
      it "should set the attribute" do
        @instance.color = 'muave'
        @instance.instance_eval do
          @color.should == 'muave'
        end
      end
      
      it "should return the new value of the attribute" do
        (@instance.color = 'muave').should == 'muave'
      end
    end # (attribute writer)
    
    describe "(attribute predicate)" do
      it "should be created" do
        @class.instance_methods.should include('color?')
      end
      
      it "should return nil if the attribute is not defined" do
        @instance.color?.should be_nil
      end
      
      it "should return true if the attribute is truthy" do
        @instance.instance_eval do
          @color = true
        end
        @instance.color?.should be_true
        
        @instance.instance_eval do
          @color = 42
        end
        @instance.color?.should be_true
      end
      
      it "should return false if the attribute is falsey" do
        @instance.instance_eval do
          @color = false
        end
        @instance.color?.should be_false
        
        @instance.instance_eval do
          @color = nil
        end
        @instance.color?.should be_false
      end
    end # (attribute predicate)
    
  end
  
  describe Pertinacious::Core do
    describe '#attribute' do
      before :each do
        @class = Class.new
        @class.class_eval do
          extend Pertinacious::Core
          attribute :color, :age
        end
        @instance = @class.new
      end
      
      it "should ...work?" do
        @class.instance_methods.should include('color', 'color=')
      end
      
    end
  end
end