require 'logger'
require 'fileutils'
require 'rest-client'

require 'monitaur/command'
require 'monitaur/plugin'
require 'monitaur/server'
require 'monitaur/client'
# require 'monitaur/config'
require 'monitaur/mixin'

module Monitaur
  VERSION = IO.read(File.join(File.dirname(File.expand_path(__FILE__)), "../VERSION"))
  
  class << self    
    attr_accessor :log_file_path, :config_dir, :raw_config,
                  :config_file_path, :env, :cache_dir
    
    def run
      Monitaur.install
      Monitaur::Client.new.run
    end
    
    def install
      create_base_dir
      create_log_file
      create_cache_dir
      create_plugin_dir
      create_config_dir
      generate_client_config unless File.exist?(config_file_path)
    end

    def env=(environment)
      @env = environment 
    end
    
    def env
      @env ||= "production"
    end
    
    def base_dir
      @base_dir ||= "#{ENV['HOME']}/.monitaur"
    end
    
    def log
      @log ||= Logger.new(log_file_path)
    end
    
    def log_file_path
      @log_file_path ||= File.join(base_dir, "client.log")
    end
    
    def config_dir
      @config_dir ||= File.join(base_dir, "")
    end
    
    def cache_dir
      @cache_dir ||= File.join(base_dir, "cache")
    end
    
    def plugin_dir
      @plugin_dir ||= File.join(cache_dir, "plugins")
    end
    
    def config_file_path
      @config_file_path ||= File.join(base_dir, "config.yml")
    end
    
    def raw_config
      @raw_config ||= IO.read(config_file_path)
    end
    
    def create_log_file
      FileUtils.touch(log_file_path)
    end
    
    def create_base_dir
      FileUtils.mkdir_p(base_dir)
    end
    
    def create_config_dir
      FileUtils.mkdir_p(config_dir)
    end
    
    def create_cache_dir
      FileUtils.mkdir_p(cache_dir)
    end
    
    def create_plugin_dir
      FileUtils.mkdir_p(plugin_dir)
    end
    
    def generate_client_config
      File.open(config_file_path, "w") do |file|
        file.puts(%q{server_url: http://api.monitaurapp.com})
        file.puts(%q{client_key: CHANGEME})
      end
    end
    
    def raw_config
      @raw_config ||= IO.read(config_file_path)
    end
  end
end
