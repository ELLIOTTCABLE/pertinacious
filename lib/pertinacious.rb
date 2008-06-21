require 'pertinacious/core_ext'

require 'pertinacious/attribute'

require 'pertinacious/core'
require 'pertinacious/base'

# Welcome to Pertinacious!
module Pertinacious
  VERSION = 0
  
  # This is incase anybody uses +include Pertinacious+ instead of the
  # correct +include Pertinacious::Core+. The former is discouraged because
  # things like our VERSION constant will be included into the target klass.
  def self.included(klass)
    klass.send :include, Pertinacious::Core
  end
end