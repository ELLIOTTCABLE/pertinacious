class Object
  unless respond_to?(:send!) #:nodoc:
    # Anticipating Ruby 1.9 neutering send
    alias send! send
  end

  # Tricky, tricky! (-:
  def truthy? #:nodoc:
    !!self
  end
end