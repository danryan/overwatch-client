require 'rest-client'
require 'clamp'
require 'formatador'
require 'yajl/json_gem'
require 'overwatch/cli/helpers'
require 'hirb'

module Overwatch
  module CLI
    class Command < Clamp::Command
      include Helpers
      
      option ["-v", "--verbose"], :flag, "be verbose"
      option "--version", :flag, "show version" do
        puts "Overwatch v#{Overwatch::CLI::VERSION} (Codename: Snickelfritz)"
        exit(0)
      end
      subcommand "resource", "Resources" do
        option ["-h", "--host"], "HOST", "overwatch-collection server", :default => "localhost"
        option ["-p", "--port"], "PORT", "overwatch-collection port", :default => "9001"
        option ["-f", "--format"], "[FORMAT]", "format (choices: pretty, json, text)", :default => "pretty"
        
        subcommand "list", "list all resources" do
          def execute
            options = { :fields => ['id','name', 'api_key'], :format => format }
            
            get("http://#{host}:#{port}/resources", options)
          end
        end
        
        subcommand "show", "show a specific resource" do
          parameter "NAME", "resource name"
          
          option ['-a', '--attributes'], :flag, "list all resource attributes"
          
          def execute
            options = { :fields => ['id','name', 'api_key'], :format => format }
            get("http://#{host}:#{port}/resources/#{name}", options)
          end
        end
          
        subcommand "create", "create a new resource" do
          parameter "NAME", "resource name"
          
          def execute
            options = { :fields => ['id','name', 'api_key'], :format => format }
            post("http://#{host}:#{port}/resources", JSON.generate({:name => name}), options)            
          end

        end
        subcommand "update", "update an existing resource"
        subcommand "delete", "delete an existing resource" do
          parameter "NAME", "resource name"
          
          def execute
            # resource = delete("http://#{host}:#{port}/resources/#{name}")
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
end