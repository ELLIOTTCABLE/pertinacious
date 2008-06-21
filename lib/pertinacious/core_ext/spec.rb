# A stub, holds a +#describe+ stub, so I can have in-file specs.
module Spec
  
  # Contains extensions to the +Kernel+ core class, and extensions placed in
  # the global namespace.
  module ::Kernel
    unless defined?(Spec::Runner)
      def describe *args
        # do nothing, as this is a stub
      end
    end
  end
  
end