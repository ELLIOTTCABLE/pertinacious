module Pertinacious
  
  # This is the basic model for a Pertinacious Accessor; that is, what is
  # created when one uses the +attr_*+ methods in a Pertinacious class.
  
  module Accessor
    
    # Unlike a traditional #new method, this method does not create a new
    # object - it creates a new method on another object, as passed into this
    # method.
    def self.new(attribute, klass, *options)
      attribute = attribute.to_s
      attribute_ivar = '@' + attribute
      
      options = options.first
      options = {:reader => true, :writer => true} unless !options.empty?
      options.reverse_merge!({:default => nil})
      raise ArgumentError, 'you have to create at least one of the reader or writer!' unless
        options[:reader] || options[:writer]
      
      if options[:reader]
        klass.class_eval do
          define_method(attribute) do
            if instance_variables.include? attribute_ivar
              instance_variable_get(attribute_ivar)
            else
              instance_variable_set(attribute_ivar, options[:default])
            end
          end # define_method
        end # class_eval
      end # if options[:reader]
      
      if options[:writer]
        klass.class_eval do
          define_method(attribute + '=') do |new_value|
            instance_variable_set(attribute_ivar, new_value)
          end # define_method
        end # class_eval
      end # if options[:writer]
    end # def new
    
  end # module Accessor
end # module Pertinacious