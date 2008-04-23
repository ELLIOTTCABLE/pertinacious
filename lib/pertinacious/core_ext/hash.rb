class Hash #:nodoc:
  def stringify_keys
    inject({}) do |new_hash, (key, value)|
      new_hash[key.to_s] = value
      new_hash
    end
  end

  def except(*keys)
    reject { |key,| keys.include?(key.to_sym) or keys.include?(key.to_s) }
  end

  def reverse_merge(other_hash)
    other_hash.merge(self)
  end

  def reverse_merge!(other_hash)
    replace(reverse_merge(other_hash))
  end
  
  def compact
    self.reject {|k, v| v == nil}
  end
  
  def compact!(method = :nil?)
    each do |key, value|
      value.compact! method if value.respond_to? :compact!
      delete key if value.send method
    end
  end
end