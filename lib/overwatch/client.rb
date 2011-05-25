require 'overwatch/mixin'
require 'yaml'
require 'ohai'

module Overwatch
  class Client
    attr_accessor :logger, :server_url, :config, :raw_config,
                  :plugin_manifest, :api_key, :data
    
    def initialize(api_key)
      @ohai = Ohai::System.new
      @api_key = api_key
      Ohai::Config[:plugin_path] << Overwatch.plugin_path unless Ohai::Config[:plugin_path].include?(Overwatch.plugin_path)
    end
    
    def run
      all_plugins
      post_data
    end
    
    def all_plugins
      @ohai.all_plugins
    end
    
    def post_data
      res = RestClient.post(
        "http://overwat.ch:9292/nodes/#{api_key}",
        Yajl.dump(data),
        { 'Content-Type' => 'application/json' }
      )
      puts res.body
    end
    
    def data
      @ohai.data
    end
  end
end