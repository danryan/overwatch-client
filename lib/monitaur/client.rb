module Monitaur
  class Client
    attr_reader :logger, :agent_key
    
    def initialize(agent_key)
      @agent_key = agent_key
    end
    
    def run
      confirm_or_create_files
      activate_logger
    end
    
    private

    def confirm_or_create_files
      if Monitaur.env == "test"
        files = [ "/tmp/var/log/monitaur.log" ]
        dirs = [ "/tmp/var/log", "/tmp/var/cache/monitaur/plugins"]
        dirs.each { |dir| FileUtils.mkdir_p(dir) unless File.exist?(dir) }
        files.each { |file| FileUtils.touch(file) unless File.exist?(file) }
      else
        files = [ "/var/log/monitaur.log" ]
        dirs = [ "/var/log", "/var/cache/monitaur/plugins"]
        dirs.each { |dir| FileUtils.mkdir_p(dir) unless File.exist?(dir) }
        files.each { |file| FileUtils.touch(file) unless File.exist?(file) }
      end
    end
    

  end
end