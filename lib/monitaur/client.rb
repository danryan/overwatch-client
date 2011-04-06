require 'monitaur/mixin'
require 'yaml'

module Monitaur
  class Client
    include Monitaur::Mixin
    
    attr_accessor :logger, :client_key, :server_url, :config, :raw_config,
                  :plugin_manifest
    
    def initialize
      load_config
      @plugin_manifest ||= []
    end
    
    def run
      get_plugin_manifest
      sync_plugins
    end
    
    def get_plugin_manifest
      res = RestClient.get("#{server_url}/nodes/#{client_key}/plugins")
      @plugin_manifest = JSON.parse(res)
    end
    
    def sync_plugins
      @plugin_manifest.each do |plugin|
        res = RestClient.get("#{server_url}/plugins/#{plugin['name']}")
        
        File.open(File.join(Monitaur.plugin_dir,"#{plugin['name']}.rb"), "w") do |file|
          file.write res
        end
        
      end
    end
    
    def load_config
      if file_exists_and_is_readable?(Monitaur.config_file_path)
        @raw_config = YAML.load_file(Monitaur.config_file_path)
      else
        raise IOError, "Cannot open or read #{Monitaur.config_file_path}"
      end
      
      @server_url = raw_config['server_url']
      @client_key = raw_config['client_key']
    end

    
  end
end