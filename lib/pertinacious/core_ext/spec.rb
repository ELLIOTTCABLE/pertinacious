class Spec
  
  module ::Kernel
    def Spec object, caller = nil, &block
      if defined?(Spec::Runner)
        caller ||= send(:const_get, File.basename(caller.first.split(':').first).split('.').first.gsub(/_/,' ').gsub(/\b\w/){$&.upcase})
        describe caller, &block
      end
    end
  end
  
end