module Overwatch
  class << self
    def plugin_path
      @plugin_path ||= File.expand_path(File.join(File.dirname(__FILE__), "../plugins"))
    end
  end
end

require 'overwatch/command'
require 'overwatch/helpers'
require 'overwatch/version'

