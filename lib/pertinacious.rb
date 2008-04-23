$LOAD_PATH.unshift(File.expand_path( File.dirname(__FILE__) )).uniq!

require 'pertinacious/core'
require 'pertinacious/base'
require 'pertinacious/attribute'

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