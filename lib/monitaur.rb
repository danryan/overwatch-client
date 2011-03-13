require 'logger'
require 'fileutils'

require 'monitaur/command'
require 'monitaur/plugin'
require 'monitaur/server'
require 'monitaur/client'

module Monitaur
  VERSION = IO.read(File.join(File.dirname(File.expand_path(__FILE__)), "../VERSION"))
  
  class << self    
    attr_writer :log_file_path, :env
    attr_accessor :agent_key
    
    def run(agent_key)
      @agent_key = agent_key
      if first_run?
        create_log_file
        create_cache_directory
      end
    end
    
    def default_env
      "production"
    end
    
    def env=(environment)
      @env = environment 
    end
    
    def env
      @env ||= default_env
    end
    
    def log
      @log ||= Logger.new(log_file_path)
    end
    
    def default_log_file_path
      "/var/log/monitaur.log"
    end
    
    def log_file_path
      @log_file_path ||= default_log_file_path
    end
    
    def first_run?
      if File.exist?("/var/log/monitaur.log") && File.exist?("/var/cache/monitaur/")
        return false
      end
      return true
    end
    
    def create_log_file
      FileUtils.mkdir_p("/var/log")
      FileUtils.touch("/var/log/monitaur.log")
    end
    
    def create_cache_directory
      FileUtils.mkdir_p("/var/cache/monitaur")
    end
  end
end
