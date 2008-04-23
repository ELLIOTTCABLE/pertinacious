class String #:nodoc:
  def ends_with?(suffix)
    suffix = suffix.to_s
    self[-suffix.length, suffix.length] == suffix
  end

  def camel_case
    split('_').map{|e| e.capitalize}.join
  end
  alias :camelize :camel_case

  def snake_case
    gsub(/\B[A-Z][^A-Z]/, '_\&').downcase.gsub(' ', '_')
  end

  def demodulize
    gsub(/^.*::/, '')
  end

  def constantize
    unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ self
      raise NameError, "#{self.inspect} is not a valid constant name!"
    end

    Object.module_eval("::#{$1}", __FILE__, __LINE__)
  end
  
  def /(o)
    File.join(self, o.to_s)
  end
  
  def unindent
    self.gsub(/^\n/, '').gsub(/^#{self.match(/^\s*/)[0]}/, '')
  end
  
  def lines
    self.split("\n").size
  end
end