module Spec
  
  module ::Kernel
    unless defined?(Spec::Runner)
      def describe *args
        # do nothing
      end
    end
  end
  
end