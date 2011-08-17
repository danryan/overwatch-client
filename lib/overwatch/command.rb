require 'rest-client'
require 'clamp'
require 'formatador'
require 'yajl/json_gem'
require 'overwatch/helpers'
require 'hirb'
require 'ohai'

module Overwatch
  class Command < Clamp::Command
    include Helpers

    option ["-v", "--verbose"], :flag, "be verbose"
    option "--version", :flag, "show version" do
      puts "Overwatch v#{Overwatch::VERSION} (Codename: Snickelfritz)"
      exit(0)
    end
    
    option ['-c', '--config'], "CONFIG", "config file"
    option ['--dry-run'], :flag, "Dry run"
    option ["-s", "--server"], "SERVER", "collection server"
    option ["-p", "--port"], "PORT", "collection port"
    option ["-f", "--format"], "[FORMAT]", "format (choices: pretty, json, text)"
    option ["-k", "--key"], "KEY", "API key"

    def config=(file)
      YAML.load_file(File.expand_path(file))
    end
    
    def default_config
      YAML.load_file(File.expand_path("~/.overwatchrc"))
    end

    def default_server
      config['server'] || 'localhost'
    end
    
    def default_port
      config['port'] || '9001'
    end
    
    def default_key
      config['key'] || nil
    end
    
    def default_format
      config['format'] || 'pretty'
    end
    
    subcommand "run", "Run the client" do
      unless Ohai::Config[:plugin_path].include?(Overwatch.plugin_path)
        Ohai::Config[:plugin_path] << Overwatch.plugin_path
      end

      Ohai::Config[:disabled_plugins] = %w{ 
        chef cloud command darwin dmi dmi_common ec2 languages 
        eucalyptus kernel keys ohai ohai_time passwd rackspace 
        virtualization c network network_listeners platform 
      }

      def execute
        @ohai = Ohai::System.new
        @ohai.all_plugins
        options = { :fields => [ 'id', 'created_at' ], :format => format }
        post("http://#{server}:#{port}/snapshots?key=#{key}", JSON.generate({:data => @ohai.data}), options)
      end  
    end

    subcommand "resource", "Resources" do

      subcommand "list", "list all resources" do
        def execute
          options = { :fields => ['id','name', 'api_key'], :format => format }

          get("http://#{server}:#{port}/resources", options)
        end
      end

      subcommand "show", "show a specific resource" do
        parameter "NAME", "resource name"

        option ['-a', '--attributes'], :flag, "list all resource attributes"

        def execute
          options = { :fields => ['id','name', 'api_key'], :format => format }
          get("http://#{server}:#{port}/resources/#{name}", options)
        end
      end

      subcommand "create", "create a new resource" do
        parameter "NAME", "resource name"

        def execute
          options = { :fields => ['id','name', 'api_key'], :format => format }
          post("http://#{server}:#{port}/resources", JSON.generate({:name => name}), options)            
        end

      end
      subcommand "update", "update an existing resource"
      subcommand "delete", "delete an existing resource" do
        parameter "NAME", "resource name"

        def execute
          # resource = delete("http://#{server}:#{port}/resources/#{name}")
          display_line "[yellow]Resource deleted![/]"
        end
      end
      subcommand "regenerate", "regenerate a resource's API key"
    end

    subcommand "snapshot", "Snapshots" do
      subcommand "show", "show an existing snapshot"
      subcommand "create", "create a new snapshot"
      subcommand "delete", "delete an existing snapshot"
    end
  end

end