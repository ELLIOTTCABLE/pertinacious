class File
  Extensions = %r=^(markdown|textile|haml|sass|css|html|xhtml|rb|txt|text|atom|rss|xml)$=i
  module Extension
    def method_missing(meth, *args)
      if Extensions =~ meth.to_s
        [self, '.', meth.to_s].join
      else
        super
      end
    end
  end
  
  module Pathize
    # Concatenates two objects into a path (a string).
    def /(o)
      File.join(self.to_s, o.to_s)
    end
  end
end