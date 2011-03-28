module Monitaur
  class Client
    attr_reader :logger, :client_key
    attr_accessor :server_url, :config, :raw_config
    
    def initialize
      load_client_config
    end

    def load_client_config
      raw_config = IO.read(Monitaur.config_file_path)
    end
  end
end