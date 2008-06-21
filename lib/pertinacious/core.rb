module Pertinacious
  
  # This module encapsulates all of the basic functionality of a Pertinacious
  # class. This is your go-to guy for Pertinacious data in ruby:
  # 
  #   class Foo
  #     include Pertinacious::Core
  #   end
  # 
  # Much of the basic functionality is in +attribute+ and it's siblings,
  # and thus in +Pertinacious::Attribute+.
  
  module Core
    
    def self.included klass
      klass.send :extend, Pertinacious::Attribute::Includes
    end
  end
end