# extracted from ActiveRecord (http://rubyforge.org/projects/activesupport/)

module Enumerable
  # Map and each_with_index combined.
  def map_with_index
    collected=[]
    each_with_index {|item, index| collected << yield(item, index) }
    collected
  end

  alias :collect_with_index :map_with_index
end
