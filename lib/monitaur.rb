require 'logger'
require 'fileutils'

require 'monitaur/command'
require 'monitaur/plugin'
require 'monitaur/server'
require 'monitaur/client'

module Monitaur
  VERSION = IO.read(File.join(File.dirname(File.expand_path(__FILE__)), "../VERSION"))
  
  class << self    
    attr_accessor :client_key, :log_file_path, :config_dir, :config_file_path, :env
    
    def install
      create_log_file
      create_cache_directory
      create_config_directory
      generate_client_config unless File.exist?(config_file_path)
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
    
    def log_file_path
      @log_file_path ||= "/var/log/monitaur.log"
    end
    
    def config_dir
      @config_dir ||= "/etc/monitaur"
    end
    
    def cache_dir
      @cache_dir ||= "/var/cache/monitaur"
    end
    
    def config_file_path
      @config_file_path ||= File.join(config_dir, "client.rb")
    end
    
    def create_log_file
      FileUtils.mkdir_p("/var/log")
      FileUtils.touch("/var/log/monitaur.log")
    end
    
    def create_cache_directory
      FileUtils.mkdir_p(cache_dir)
    end
    
    def create_config_directory
      FileUtils.mkdir_p(config_dir)
    end
    
    def generate_client_config
      File.open(config_file_path, "w") do |file|
        file.puts(%q{server_url "http://api.monitaurapp.com"})
        file.puts(%q{client_key "CHANGEME"})
      end
    end
    
    def raw_config
      @raw_config ||= IO.read(config_file_path)
    end
  end
end
