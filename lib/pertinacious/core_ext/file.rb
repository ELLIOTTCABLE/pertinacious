# See {File::Extension} and {File::Pathize#/}
class File
  
  # If a missing method is called, and it matches the {Extensions} regex, it
  # will be appended.
  module Extension
    # Valid file extensions to catch as 'methods'
    Extensions = %r=^(markdown|textile|haml|sass|css|html|xhtml|rb|txt|text|atom|rss|xml)$=i
    
    # Appends any missing method if it matches the {Extensions} regex.
    def method_missing(meth, *args)
      if Extensions =~ meth.to_s
        [self, '.', meth.to_s].join
      else
        super
      end
    end
  end
  
  # See {#/}
  module Pathize
    # Concatenates self, with another object, into a path (a string).
    # @param [String, Symbol, #to_s] other the object to concatenate to self
    def /(other)
      File.join(self.to_s, other.to_s)
    end
  end
  
end

# Specs are in string.rb and symbol.rb